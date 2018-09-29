# frozen_string_literal: true

class Check
  module Chartable
    extend ActiveSupport::Concern

    included do
      has_many_attached :charts
    end

    def create_chart
      CreateChart.new(self).execute
    end
  end
end
