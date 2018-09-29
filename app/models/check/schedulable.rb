# frozen_string_literal: true

class Check
  module Schedulable
    extend ActiveSupport::Concern

    included do
      after_create_commit :schedule
    end

    private

    def schedule
      ping_later
      certify_later
      whois_later
      burn_later
    end
  end
end
