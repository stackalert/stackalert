# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/subscriber_mailer
class SubscriberMailerPreview < ActionMailer::Preview
  def notify
    SubscriberMailer.with(subscriber: StatusPageSubscriber.first,
                          status_page: StatusPage.first,
                          check: Check.first).notify
  end
end
