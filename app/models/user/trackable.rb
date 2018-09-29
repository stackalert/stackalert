# frozen_string_literal: true

class User
  module Trackable
    extend ActiveSupport::Concern

    def track
      self.sign_in_count += 1
      self.last_sign_in_ip = current_sign_in_ip
      self.current_sign_in_ip = Current.request_ip
      self.last_sign_in_at = current_sign_in_at
      self.current_sign_in_at = Time.current
      save!
    end
  end
end
