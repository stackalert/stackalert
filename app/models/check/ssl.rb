# frozen_string_literal: true

class Check
  class Ssl
    def initialize(check)
      @check = check
    end

    def run
      net_http.use_ssl = true
      net_http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      net_http.start do |h|
        cert = h.peer_cert
        check_certificate.update_attributes valid_on: cert.not_before, valid_until: cert.not_after, issuer: cert.issuer
      end
    end

    private

    def net_http
      @net_http ||= Net::HTTP.new(@check.endpoint_uri.host, @check.endpoint_uri.port)
    end

    def check_certificate
      @check_certificate ||= @check.check_certificate || @check.build_check_certificate
    end

    def client
      @client ||= Socket.tcp(@check.host, 443, connect_timeout: 5)
    end

    def ssl_client
      @ssl_client ||= OpenSSL::SSL::SSLSocket.new(client)
    end
  end
end
