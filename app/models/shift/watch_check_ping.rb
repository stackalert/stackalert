# frozen_string_literal: true

class Shift
  module WatchCheckPing
    extend ActiveSupport::Concern

    class_methods do
      def check_ping_created(check_ping)
        check_ping.check.team.shifts.each { |shift| shift.trigger(check_ping.check) }
      end
    end
  end
end
