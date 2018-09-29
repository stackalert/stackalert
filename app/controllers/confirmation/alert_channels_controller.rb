# frozen_string_literal: true

module Confirmation
  class AlertChannelsController < ApplicationController
    def create
      @alert_channel = AlertChannel.find_by! confirmation_token: params[:confirmation_token]

      @alert_channel.confirm!

      redirect_to team_alert_path(@alert_channel.alert.team, @alert_channel.alert, notice: 'Email Confirmed!')
    end
  end
end
