# frozen_string_literal: true

module Confirmation
  class UsersController < ApplicationController
    def create
      @user = User.find_by! confirmation_token: params[:confirmation_token]

      @user.confirm!

      redirect_to teams_path(notice: 'Email Confirmed!')
    end
  end
end
