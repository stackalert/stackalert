# frozen_string_literal: true

module Teams
  class IdentitiesController < Teams::ApplicationController
    def index
      @team_identities = policy_scope(TeamIdentity)
      respond_to do |format|
        format.html { render :index }
        format.json { render json: @team_identity }
      end
    end
  end
end
