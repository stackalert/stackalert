# frozen_string_literal: true

class Check
  class PingJob < ApplicationJob
    include Concerns::NoRetry

    queue_as :high_priority

    def perform(check_id)
      return unless (check = Check.find_by(id: check_id))
      self.class.set(wait_until: check.every.minutes.from_now).perform_later(check.id)
      check.ping
    end
  end
end
