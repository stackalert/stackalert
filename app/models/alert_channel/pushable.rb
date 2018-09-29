# frozen_string_literal: true

class AlertChannel
  module Pushable
    extend ActiveSupport::Concern

    def push_later(alert_rule, check)
      AlertChannel::PushJob.perform_later(self, alert_rule, check)
    end
  end
end
