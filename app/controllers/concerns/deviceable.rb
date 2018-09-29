# frozen_string_literal: true

module Concerns
  module Deviceable
    extend ActiveSupport::Concern

    included do
      before_action :detect_device_format
    end

    private

    def detect_device_format
      case request.user_agent
      when /Stack Alert Mobile/i
        request.variant = :mobile
      end
    end
  end
end
