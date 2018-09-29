# frozen_string_literal: true

class Team
  module Slack
    class Bind
      def initialize(team, code)
        @team = team
        @code = code
      end

      def execute
        @team.team_identities
             .create_with(uid: client['team_id'], name: client['team_name'], provider: 'slack')
             .find_or_create_by!(oauth_token: client['bot']['bot_access_token'])
      end

      private

      def client
        @client ||= ::Slack::Web::Client.new.oauth_access(
          client_id: Rails.application.credentials[Rails.env.to_sym][:slack_client_id],
          client_secret: Rails.application.credentials[Rails.env.to_sym][:slack_client_secret],
          code: @code
        )
      end
    end
  end
end
