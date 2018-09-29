# frozen_string_literal: true

class AlertChannelEndpoint < AlertChannel
  has_paper_trail only: [:endpoint]

  validates :endpoint, presence: true
  validates :endpoint, url: true
  validates :endpoint, length: { minimum: 2, maximum: 30 }

  def to_s
    endpoint
  end

  def push(alert_rule, check)
    success = nil
    begin
      success = HTTParty.post(endpoint,
                              body: { rule: { type: alert_rule.type, threshold: alert_rule.treshold },
                                      check_name: check.name,
                                      alert_name: alert.name }, timeout: 10).success?
    rescue HTTParty::Error, Timeout::Error, SocketError
      success = false
    ensure
      create_event(success, alert_rule, check)
    end
  end
end
