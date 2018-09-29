# frozen_string_literal: true

class AlertChannel
  class PushJob < ApplicationJob
    queue_as :low_priority

    def perform(alert_channel, alert_rule, check)
      alert_channel.push(alert_rule, check)
    end
  end
end
