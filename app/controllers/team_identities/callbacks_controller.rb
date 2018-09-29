# frozen_string_literal: true

module TeamIdentities
  class CallbacksController < ApplicationController
    before_action :ensure_code

    def twitter
      access_token = request_token.get_access_token(oauth_verifier: params[:oauth_verifier])
      team.bind_with_twitter(access_token)
      redirect_to team_identities_path(team)
    end

    def slack
      team.bind_with_slack(params[:code])
    rescue Slack::Web::Api::Errors::SlackError
      Rails.logger.info "Invalid code for team: #{params[:state]}"
    ensure
      redirect_to team_identities_path(team)
    end

    private

    def request_token
      @request_token ||= ::OAuth::RequestToken.new(twitter_client,
                                                   session['oauth_twitter'].delete('request_token'),
                                                   session['oauth_twitter'].delete('request_secret'))
    end

    def twitter_client
      @twitter_client ||= ::OAuth::Consumer.new(Rails.application.credentials[Rails.env.to_sym][:twitter_client_id],
                                                Rails.application.credentials[Rails.env.to_sym][:twitter_client_secret],
                                                authorize_path: '/oauth/authenticate',
                                                site: 'https://api.twitter.com')
    end

    def team
      Team.find params[:state]
    end

    def ensure_code
      redirect_to team_identities_path(team) if params[:code].nil? && params[:oauth_verifier].nil?
    end
  end
end
