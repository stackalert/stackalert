# frozen_string_literal: true

class AlertChannel
  module Eventable
    extend ActiveSupport::Concern

    included do
      has_many :alert_events, dependent: :destroy
    end

    def create_event(success, alert_rule, check)
      alert_events.create(alert_rule: alert_rule,
                          success: success,
                          check_endpoint: check.endpoint)
    end
  end
end
