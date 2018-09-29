# frozen_string_literal: true

module Concerns
  module Resetable
    extend ActiveSupport::Concern

    included do
      after_action :reset!
    end

    private

    def reset!
      Current.reset!
    end
  end
end
