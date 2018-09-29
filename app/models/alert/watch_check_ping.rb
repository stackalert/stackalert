# frozen_string_literal: true

class Alert
  module WatchCheckPing
    extend ActiveSupport::Concern

    class_methods do
      def check_ping_created(check_ping)
        check_ping.check.alerts.each { |alert| alert.trigger_later(check_ping.check) }
      end
    end
  end
end
