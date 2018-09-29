# frozen_string_literal: true

class Alert
  module Triggerable
    extend ActiveSupport::Concern

    def trigger_later(check)
      Trigger.new(self, check).run_later
    end
  end
end
