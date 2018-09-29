# frozen_string_literal: true

class AlertRule < ApplicationRecord
  belongs_to :alert
  has_many :alert_events, dependent: :destroy
  validates :threshold, numericality: { only_integer: true,
                                        greater_than: 0,
                                        less_than: 61 }
  validates :alert, :name, presence: true

  enum name: CheckPing.states

  def to_s
    "After #{threshold} #{name}"
  end

  protected

  def <=>(other)
    to_i <=> other.to_i
  end

  def to_i
    100 * self.class.names[name] + threshold
  end
end
