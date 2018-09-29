# frozen_string_literal: true

module Teams
  class ApplicationController < ::ApplicationController
    before_action :authenticated!
    before_action :find_team

    private

    def find_team
      Current.team = policy_scope(Team).friendly.find(params[:team_id])
    end
  end
end
