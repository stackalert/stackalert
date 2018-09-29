# frozen_string_literal: true

module Constraints
  class Html
    def self.matches?(request)
      request.format == :html
    end
  end
end
