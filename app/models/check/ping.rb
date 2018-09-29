# frozen_string_literal: true

class Check
  class Ping
    PingResult = Struct.new(:http_code,
                            :name_lookup_time,
                            :connect_time,
                            :app_connect_time,
                            :pre_transfer_time,
                            :redirect_time,
                            :start_transfer_time,
                            :total_time)

    TO_MS = 1000

    def initialize(check)
      @check = check
    end

    def perform
      @check.check_pings.create!(ping_result.to_h.merge(state: state))
    end

    private

    def ping_result
      @ping_result ||= make_request
    end

    def timeout
      Check::MAX_THRESHOLD / 1000
    end

    def state
      @state ||= begin
                   return :danger if danger?
                   return :success if success?

                   :warning
                 end
    end

    def success?
      ping_result.total_time <= @check.warning_threshold
    end

    def danger?
      ping_result.http_code.to_s[0] == '5' || ping_result.total_time >= @check.danger_threshold
    end

    def make_request
      Rails.cache.fetch("#{@check.cache_key}/endpoint_result", expires_in: 1.minutes) do
        curl_success curl(@check)
      rescue StandardError => e
        Rails.logger.info e.inspect
        curl_error
      end
    end

    def curl(check)
      Curl::Easy.perform(check.endpoint) do |curl|
        curl.headers['User-Agent'] = 'Stack Alert'
        curl.connect_timeout = timeout
        curl.ssl_verify_peer = false
      end
    end

    def curl_success(curl)
      PingResult.new(curl.response_code,
                     curl.name_lookup_time * TO_MS,
                     curl.connect_time * TO_MS,
                     curl.app_connect_time * TO_MS,
                     curl.pre_transfer_time * TO_MS,
                     curl.redirect_time * TO_MS,
                     curl.start_transfer_time * TO_MS,
                     curl.total_time * TO_MS)
    end

    def curl_error
      max = Check::MAX_THRESHOLD + 1
      PingResult.new(500, max, max, max, max, max, max, max)
    end
  end
end
