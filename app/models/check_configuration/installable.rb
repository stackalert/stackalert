# frozen_string_literal: true

class CheckConfiguration
  module Installable
    extend ActiveSupport::Concern

    def install
      values.map do |attributes|
        Current.team.checks.create!(attributes)
      end
    end
  end
end
