# frozen_string_literal: true

module Slacks
  class ApplicationController < ActionController::Base
    before_action :find_team_identities

    private

    def find_team_identities
      @team_identities = TeamIdentity.where(uid: team_id, provider: 'slack')
    end

    def team_id
      params[:team_id] || payload.dig('team', 'id')
    end

    def payload
      @payload ||= begin
                     JSON.parse(params[:payload])
                   rescue StandardError
                     {}
                   end
    end
  end
end
