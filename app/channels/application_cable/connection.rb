# frozen_string_literal: true

module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = user
    end

    private

    def user
      @user ||= User.find_by(id: cookies.signed[:user_id])
    rescue ActiveRecord::RecordNotFound
      reject_unauthorized_connection
    end
  end
end
