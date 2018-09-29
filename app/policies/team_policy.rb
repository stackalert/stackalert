# frozen_string_literal: true

class TeamPolicy < ApplicationPolicy
  class Scope
    attr_reader :current, :scope

    def initialize(current, scope)
      @current = current
      @scope = scope
    end

    def resolve
      scope.where(id: current.user.teams)
    end
  end
end
