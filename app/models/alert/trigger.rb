# frozen_string_literal: true

class Alert
  class Trigger
    def initialize(alert, check)
      @alert = alert
      @check = check
    end

    def run_later
      return if active_rule.blank?

      @alert.alert_channels.map { |alert_channel| alert_channel.push_later(active_rule, @check) }
    end

    private

    def active_rule
      @active_rule ||= @alert.alert_rules.sort.find do |rule|
        @check.on?(count: rule.threshold, state: rule.name)
      end
    end
  end
end
