# frozen_string_literal: true

class TeamChannel < ApplicationCable::Channel
  def subscribed
    team = current_user.teams.friendly.find(params[:team_id])
    stream_for team
  end
end
