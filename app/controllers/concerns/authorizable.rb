# frozen_string_literal: true

module Concerns
  module Authorizable
    extend ActiveSupport::Concern

    included do
      include Pundit

      def pundit_user
        Current
      end
    end
  end
end
