# frozen_string_literal: true

module Slacks
  class ActionsController < ApplicationController
    def create
      @team_identities.each { |team_identity| team_identity.slack_action(payload) }

      head :ok
    end
  end
end
