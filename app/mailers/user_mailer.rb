# frozen_string_literal: true

class UserMailer < ApplicationMailer
  helper :application

  def welcome
    @user = params[:user]
    mail(to: @user.email, subject: 'Welcome to Stack Alert')
  end

  def confirmation_instructions
    @user = params[:user]
    @token = params[:token]
    mail(to: @user.unconfirmed_email, subject: '[Stack Alert] Email confirmation instructions')
  end
end
