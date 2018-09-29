# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/alert_mailer
class AlertChannelEmailMailerPreview < ActionMailer::Preview
  def notify
    AlertChannelEmailMailer.with(alert_channel: AlertChannelEmail.first,
                                 alert_rule: AlertRule.first,
                                 check: Check.first).notify
  end

  def confirmation_instructions
    AlertChannelEmailMailer.with(alert_channel: AlertChannelEmail.first,
                                 token: 'token').confirmation_instructions
  end
end
