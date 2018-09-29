# frozen_string_literal: true

class Team
  class Registrar
    def initialize(attributes)
      @attributes = attributes
      @team = find_team
    end

    def join_or_create
      @team.present? ? join : create
      @team
    end

    private

    def join
      @team.users << Current.user
    end

    def create
      @team = Team.new(team_attributes).tap do |team|
        team.team_identities.build(identity_attributes) if provider.present? && uid.present?
        team.users << Current.user
        team.save
      end
    end

    def team_attributes
      @attributes.reject { |key, _| %w[provider uid].include? key }
    end

    def identity_attributes
      @attributes.reject { |key, _| %w[time_zone avatar avatar_url].include? key }
    end

    def find_team
      TeamIdentity.find_by(provider: provider, uid: uid).try(:team)
    end

    def provider
      @attributes[:provider]
    end

    def uid
      @attributes[:uid]
    end
  end
end
