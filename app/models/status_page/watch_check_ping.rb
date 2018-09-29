# frozen_string_literal: true

class StatusPage
  module WatchCheckPing
    extend ActiveSupport::Concern

    class_methods do
      def check_ping_created(check_ping)
        check_ping.check.team.status_page.notify_subscribers_about(check_ping.check)
      end
    end
  end
end
