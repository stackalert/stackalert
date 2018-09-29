# frozen_string_literal: true

module Concerns
  module SignIn
    extend ActiveSupport::Concern

    def sign_in
      cookies.signed[:user_id] = Current.user.id
    end

    def reset_sign_in
      cookies.signed[:user_id] = nil
    end
  end
end
