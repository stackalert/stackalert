# frozen_string_literal: true

class StatusPage
  module Subscribable
    extend ActiveSupport::Concern

    included do
      has_many :status_page_subscribers, dependent: :destroy
    end

    def notify_subscribers_about(check)
      Notifier.new(self, check).call
    end
  end
end
