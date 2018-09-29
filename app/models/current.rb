# frozen_string_literal: true

class Current
  thread_cattr_accessor :user, :team, :request_ip

  def self.reset!
    Current.user = nil
    Current.team = nil
    Current.request_ip = nil
  end
end
