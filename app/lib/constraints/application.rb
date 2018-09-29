# frozen_string_literal: true

module Constraints
  class Application
    def self.matches?(request)
      request.format == :html || request.format == :js || request.format == :json
    end
  end
end
