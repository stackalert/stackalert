# frozen_string_literal: true

class TeamIdentity
  class EventMessage
    def initialize(team_identity, event)
      @team = team_identity.team
      @event = event
    end

    def generate
      event_message_type.try(:generate)
    end

    private

    def event_message_type
      if checks?
        EventMessage::Team.new(@team)
      elsif check.present?
        EventMessage::Check.new(check)
      elsif help?
        EventMessage::Help.new
      end
    end

    def checks?
      text.include?('!checks')
    end

    def help?
      text.include?('!help')
    end

    def check
      @check ||= begin
        if text.include?('!check')
          name = text.split(' ', 2).last
          @team.checks.where('lower(name) = ?', name.downcase).first
        end
      end
    end

    def text
      @event[:text].downcase
    end
  end
end
