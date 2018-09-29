# frozen_string_literal: true

class TeamIdentity
  class EventMessage
    class Help
      def generate
        [text, nil]
      end

      private

      def text
        ['Prefix all the following command with `!`:',
         '`help` - Show this help',
         '`checks` - List the team checks',
         '`check` <name> - Get info about the check'].join("\n")
      end
    end
  end
end
