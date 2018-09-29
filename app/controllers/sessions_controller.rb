# frozen_string_literal: true

class SessionsController < ApplicationController
  before_action :authenticated!, only: :destroy

  def create
    Current.user = User.sign_in_or_create(auth)
    sign_in
    after_sign_in_redirect
  end

  def failure
    redirect_to page_path('sign-in')
  end

  def destroy
    reset_sign_in
    redirect_to root_url
  end

  private

  def after_sign_in_redirect
    redirect_to session[:user_return_to] || go_to_app_path
    session.delete(:return_to)
  end

  def auth
    request.env['omniauth.auth']
  end
end
