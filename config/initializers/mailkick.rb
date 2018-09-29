# frozen_string_literal: true

# Override default => mailkick needs to update Gibbon
module Mailkick
  class Service
    class Mailchimp < Mailkick::Service
      def self.discoverable?
        false
      end
    end
  end
end
