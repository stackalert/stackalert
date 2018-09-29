# frozen_string_literal: true

class StatusPage
  module Checkable
    extend ActiveSupport::Concern

    included do
      has_many :checks

      before_destroy :reset_checks
    end

    def success?
      checks.all? { |check| check.ping_state == 'success' }
    end

    private

    def reset_checks
      checks.update_all status_page_id: nil
    end
  end
end
