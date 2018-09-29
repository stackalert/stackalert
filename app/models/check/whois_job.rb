# frozen_string_literal: true

class Check
  class WhoisJob < ApplicationJob
    include Concerns::NoRetry

    queue_as :low_priority

    WAIT_UNTIL = 24.hours

    def perform(check_id)
      return unless (check = Check.find_by(id: check_id))
      self.class.set(wait_until: WAIT_UNTIL.from_now).perform_later(check.id)
      check.whois
    end
  end
end
