# frozen_string_literal: true

class TeamIdentity
  class EventMessage
    class Check
      def initialize(check)
        @check = check
      end

      def generate
        @check.create_chart
        [text, [@check.slack_attachment_detail]]
      end

      private

      def text
        "#{@check.name} Summary"
      end
    end
  end
end
