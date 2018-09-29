# frozen_string_literal: true

class AlertChannelEmail < AlertChannel
  include Concerns::Confirmable

  has_paper_trail only: [:email]

  validates :email, presence: true
  validates :email, email: true
  validates :email, length: { minimum: 2, maximum: 100 }
  validates :unconfirmed_email, email: true, allow_blank: true
  validates :unconfirmed_email, length: { minimum: 2, maximum: 100 }, allow_blank: true

  def to_s
    email
  end

  def push(alert_rule, check)
    AlertChannelEmailMailer.with(alert_channel: self, alert_rule: alert_rule, check: check)
                           .notify
                           .deliver_now
    create_event(true, alert_rule, check)
  end

  def send_confirmation_instructions
    AlertChannelEmailMailer.with(alert_channel: self, token: confirmation_token)
                           .confirmation_instructions
                           .deliver_later
  end
end
