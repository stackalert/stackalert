# frozen_string_literal: true

class Team
  module WatchCheckPing
    extend ActiveSupport::Concern

    class_methods do
      def check_ping_created(check_ping)
        check = check_ping.check
        Current.team = check.team
        TeamChannel.broadcast_to(check.team, check.render)
        Current.team = nil
      end
    end
  end
end
