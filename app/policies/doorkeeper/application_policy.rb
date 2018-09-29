# frozen_string_literal: true

module Doorkeeper
  class ApplicationPolicy < ::ApplicationPolicy
    class Scope
      attr_reader :current, :scope

      def initialize(current, scope)
        @current = current
        @scope = scope
      end

      def resolve
        scope.where(owner: current.user)
      end
    end
  end
end
