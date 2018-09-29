# frozen_string_literal: true

class AlertChannelSlack < AlertChannel
  belongs_to :team_identity

  has_paper_trail only: [:slack_channel]

  validates :slack_channel, presence: true
  validates :slack_channel, length: { minimum: 2, maximum: 249 }

  def to_s
    slack_channel
  end

  def push(alert_channel, alert_rule, check)
    text = "#{check.name} triggered the alert #{alert.name}\nThe following rule has been reached: #{alert_rule}"
    slack.save_remote(alert_channel.slack_channel, text)
    create_event(true, alert_rule, check)
  end
end
