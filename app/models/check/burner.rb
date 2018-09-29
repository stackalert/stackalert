# frozen_string_literal: true

class Check
  class Burner
    PING_LIMIT = 300

    def initialize(check)
      @check = check
    end

    def perform
      burn_check_pings
      burn_charts
    end

    private

    attr_reader :check

    def burn_check_pings
      check.check_pings.order(:created_at).first(check.check_pings_count - PING_LIMIT).map(&:destroy)
    end

    def burn_charts
      check.charts.first(10).map(&:purge)
    end
  end
end
