# frozen_string_literal: true

module Concerns
  module NoRetry
    extend ActiveSupport::Concern

    included do
      rescue_from(StandardError) do |exception|
        logger.error exception.backtrace.join("\n")
      end
    end
  end
end
