# frozen_string_literal: true

module Concerns
  module GoToApp
    extend ActiveSupport::Concern

    included do
      helper_method :go_to_app_path
    end

    private

    def go_to_app_path
      Current.team.present? || policy_scope(Team).any? ? teams_path : new_team_path
    end
  end
end
