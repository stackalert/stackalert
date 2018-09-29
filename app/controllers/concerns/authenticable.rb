# frozen_string_literal: true

module Concerns
  module Authenticable
    extend ActiveSupport::Concern
    include Concerns::Authenticable::Api
    include Concerns::Authenticable::Session

    included do
      before_action :set_current
    end

    private

    def authenticated!
      redirect_to page_path('sign-in') if Current.user.blank?
    end

    def set_current
      Current.user = user
      Current.request_ip = request.ip
    end

    def user
      @user ||= access_token_user || session_user
    end
  end
end
