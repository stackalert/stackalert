# frozen_string_literal: true

class AlertEventPolicy < ApplicationPolicy
  class Scope
    attr_reader :current, :scope

    def initialize(current, scope)
      @current = current
      @scope = scope
    end

    def resolve
      scope.joins(alert_channel: [alert: :team]).where(teams: { id: current.team })
    end
  end
end
