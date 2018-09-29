# frozen_string_literal: true

class TeamIdentity
  class EventMessage
    class Team
      def initialize(team)
        @team = team
      end

      def generate
        [text, @team.checks.all.map(&:slack_attachment)]
      end

      private

      def text
        "Checks for #{@team.name}"
      end
    end
  end
end
