# frozen_string_literal: true

class AlertEvent < ApplicationRecord
  belongs_to :alert_channel, counter_cache: true
  belongs_to :alert_rule, counter_cache: true

  validates :alert_channel, :alert_rule, :check_endpoint, presence: true
end
