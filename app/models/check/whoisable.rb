# frozen_string_literal: true

class Check
  module Whoisable
    extend ActiveSupport::Concern

    included do
      has_one :check_domain, dependent: :destroy
    end

    def whois
      Check::Whois.new(self).execute
    end

    def whois_later
      Check::WhoisJob.perform_later(id)
    end

    def domain
      PublicSuffix.parse(endpoint_uri.host).domain
    end
  end
end
