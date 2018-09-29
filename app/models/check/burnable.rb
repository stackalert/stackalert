# frozen_string_literal: true

class Check
  module Burnable
    extend ActiveSupport::Concern

    def burn_later
      Check::BurnerJob.perform_later(id)
    end

    def burn
      Check::Burner.new(self).perform
    end
  end
end
