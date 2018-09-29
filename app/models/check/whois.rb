# frozen_string_literal: true

class Check
  class Whois
    def initialize(check)
      @check = check
    end

    def execute
      check_domain.update_attributes valid_on: valid_on,
                                     valid_until: valid_until,
                                     registrar: registrar,
                                     raw: whois.record.to_s
    end

    private

    def valid_on
      whois.created_on
    rescue StandardError
      nil
    end

    def valid_until
      whois.expires_on
    rescue StandardError
      nil
    end

    def registrar
      whois.registrar.try(&:name) || ''
    rescue StandardError
      ''
    end

    def check_domain
      @check_domain ||= @check.check_domain || @check.build_check_domain
    end

    def whois
      @whois ||= ::Whois.whois(@check.domain).parser
    end
  end
end
