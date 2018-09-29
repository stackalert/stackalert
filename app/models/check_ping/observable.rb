# frozen_string_literal: true

class CheckPing
  module Observable
    extend ActiveSupport::Concern

    included do
      after_create :notify
    end

    def notify
      [Team, Alert, Shift, StatusPage].each do |observer|
        observer.send :check_ping_created, self
      end
    end
  end
end
