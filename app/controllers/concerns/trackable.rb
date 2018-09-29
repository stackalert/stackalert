# frozen_string_literal: true

module Concerns
  module Trackable
    extend ActiveSupport::Concern

    included do
      before_action :set_paper_trail_whodunnit
    end

    private

    def user_for_paper_trail
      Current.user
    end
  end
end
