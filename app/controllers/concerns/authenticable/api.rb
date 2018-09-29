# frozen_string_literal: true

module Concerns
  module Authenticable
    module Api
      extend ActiveSupport::Concern

      def access_token_user
        return if doorkeeper_token.blank?

        User.find doorkeeper_token.resource_owner_id
      end
    end
  end
end
