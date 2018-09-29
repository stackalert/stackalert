# frozen_string_literal: true

module Concerns
  module Authenticable
    module Session
      extend ActiveSupport::Concern

      def session_user
        User.find_by id: cookies.signed[:user_id] if cookies.signed[:user_id].present?
      end
    end
  end
end
