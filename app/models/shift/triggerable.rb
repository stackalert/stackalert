# frozen_string_literal: true

class Shift
  module Triggerable
    extend ActiveSupport::Concern

    def trigger(check)
      return unless perform?(check)
      alert.trigger_later(check)
    end

    private

    def perform?(check)
      shift_opening.cover?(Time.now.in_time_zone(check.team.time_zone))
    end
  end
end
