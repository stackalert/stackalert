# frozen_string_literal: true

module Teams
  class UsersController < Teams::ApplicationController
    def index
      @users = policy_scope(User)
      respond_to do |format|
        format.html { render :index }
        format.json { render json: @users }
      end
    end
  end
end
