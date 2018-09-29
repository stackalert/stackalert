# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  class Scope
    attr_reader :current, :scope

    def initialize(current, scope)
      @current = current
      @scope = scope
    end

    def resolve
      scope.joins(:teams).where(teams: { id: current.team })
    end
  end

  def edit?
    current.user == record
  end

  alias update? edit?
end
