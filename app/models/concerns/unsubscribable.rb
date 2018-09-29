# frozen_string_literal: true

module Concerns
  module Unsubscribable
    extend ActiveSupport::Concern

    included do
      mailkick_user
    end
  end
end
