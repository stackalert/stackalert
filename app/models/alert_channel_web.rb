# frozen_string_literal: true

class AlertChannelWeb < AlertChannel
  def push(_alert_channel, alert_rule, check)
    text = "#{check.name} triggered the alert #{alert.name}\nThe following rule has been reached: #{alert_rule}"
    check.team.users.each do |user|
      browser_push = user.browser_push
      next if browser_push.blank?
      Webpush.payload_send(message: text,
                           endpoint: browser_push.endpoint,
                           p256dh: browser_push.p256dh,
                           auth: browser_push.auth,
                           vapid: {
                             public_key: Rails.application.credentials.vapid_public_key,
                             private_key: Rails.application.credentials.vapid_private_key
                           })
      create_event(true, alert_rule, check)
    end
  end
end
