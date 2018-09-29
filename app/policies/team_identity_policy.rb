# frozen_string_literal: true

class TeamIdentityPolicy < ApplicationPolicy
  class Scope
    attr_reader :current, :scope

    def initialize(current, scope)
      @current = current
      @scope = scope
    end

    def resolve
      scope.where(team: current.team)
    end
  end
end
