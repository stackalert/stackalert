# frozen_string_literal: true

class ShiftOpening < ApplicationRecord
  has_one :shift

  serialize :days, Array

  validates :days, :starts_at, :ends_at, presence: true
  validates :days, array_of_days: true
  validate :starts_at_before_ends_at

  acts_as_paranoid

  has_paper_trail only: %i[starts_at ends_at days]

  def on_day?(reference_at)
    days.include?(reference_at.strftime('%A'))
  end

  def cover?(reference_at)
    on_day?(reference_at) &&
      Tod::Shift.new(starts_at.to_time_of_day, ends_at.to_time_of_day).include?(reference_at.to_time_of_day)
  end

  private

  def starts_at_before_ends_at
    return if starts_at.nil? || ends_at.nil?
    errors.add(:starts_at, 'must be before ends at') unless starts_at < ends_at
  end
end
