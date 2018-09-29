# frozen_string_literal: true

class StatusPage
  class Notifier
    def initialize(status_page, check)
      @status_page = status_page
      @check = check
    end

    def call
      return unless @check.on?(count: 10, state: 'error')

      @status_page.subscribers.find_each do |subscriber|
        SubscriberMailer.push(subscriber, @check).deliver_later
      end
    end
  end
end
