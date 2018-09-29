# frozen_string_literal: true

class Team
  module Slack
    module Channelable
      extend ActiveSupport::Concern

      def channels
        slack_identities.map do |identity|
          [identity, identity.channels]
        end
      end
    end
  end
end
