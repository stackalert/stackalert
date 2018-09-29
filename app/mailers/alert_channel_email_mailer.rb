# frozen_string_literal: true

class AlertChannelEmailMailer < ApplicationMailer
  helper :application

  def notify
    @alert_channel = params[:alert_channel]
    @alert_rule = params[:alert_rule]
    @check = params[:check]
    mail(to: @alert_channel.email, subject: "[Stack Alert] #{@check.name} triggered an alert")
  end

  def confirmation_instructions
    @alert_channel = params[:alert_channel]
    @token = params[:token]
    mail(to: @alert_channel.unconfirmed_email, subject: '[Stack Alert] Alert Channel Email confirmation instructions')
  end
end
