# frozen_string_literal: true

class Team
  module Twitter
    class Bind
      def initialize(team, access_token)
        @team = team
        @access_token = access_token
      end

      def execute
        @team.team_identities
             .create_with(uid: client.user.id, name: client.user.name, provider: 'twitter')
             .find_or_create_by!(oauth_token: @access_token.token, oauth_secret: @access_token.secret)
      end

      private

      def client
        @client ||= ::Twitter::REST::Client.new do |config|
          config.consumer_key = Rails.application.credentials[Rails.env.to_sym][:twitter_client_id]
          config.consumer_secret = Rails.application.credentials[Rails.env.to_sym][:twitter_client_secret]
          config.access_token = @access_token.token
          config.access_token_secret = @access_token.secret
        end
      end
    end
  end
end
