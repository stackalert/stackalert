# frozen_string_literal: true

module Slacks
  class EventsController < ApplicationController
    def create
      @team_identities.each { |team_identity| team_identity.slack_receive(params[:event]) }
      render plain: params[:challenge]
    end
  end
end
