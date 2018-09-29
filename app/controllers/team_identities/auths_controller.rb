# frozen_string_literal: true

module TeamIdentities
  class AuthsController < ApplicationController
    def twitter
      request_token = client.get_request_token({ oauth_callback: callback_url }, x_auth_access_type: 'read-write')
      session['oauth_twitter'] = { 'request_token' => request_token.token,
                                   'request_secret' => request_token.secret }
      redirect_to request_token.authorize_url
    end

    private

    def callback_url
      team_identities_twitter_callback_url(state: params[:team_id])
    end

    def client
      @client ||= ::OAuth::Consumer.new(Rails.application.credentials[Rails.env.to_sym][:twitter_client_id],
                                        Rails.application.credentials[Rails.env.to_sym][:twitter_client_secret],
                                        authorize_path: '/oauth/authenticate',
                                        site: 'https://api.twitter.com')
    end
  end
end
