# frozen_string_literal: true

class CheckConfigurationPolicy < ApplicationPolicy
  class Scope
    attr_reader :current, :scope

    def initialize(current, scope)
      @current = current
      @scope = scope
    end

    def resolve
      scope.all
    end
  end
end
