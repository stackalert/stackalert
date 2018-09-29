# frozen_string_literal: true

class AlertChannel < ApplicationRecord
  include AlertChannel::Eventable
  include AlertChannel::Pushable

  belongs_to :alert, counter_cache: true

  acts_as_paranoid

  validates :alert, presence: true
end
