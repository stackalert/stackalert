# frozen_string_literal: true

class StatusPageIncidentPolicy < ApplicationPolicy
  class Scope
    attr_reader :current, :scope

    def initialize(current, scope)
      @current = current
      @scope = scope
    end

    def resolve
      scope.joins(status_page: :team).where(teams: { id: current.team })
    end
  end
end
