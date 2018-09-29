# frozen_string_literal: true

class Shift < ApplicationRecord
  include Shift::WatchCheckPing
  include Shift::Triggerable
  include PgSearch

  pg_search_scope :search, against: [:name], using: {
    tsearch: { prefix: true, any_word: true }
  }

  acts_as_paranoid

  has_paper_trail only: %i[name]

  include FriendlyId
  friendly_id :name, use: :scoped, scope: :team

  belongs_to :team, counter_cache: true
  belongs_to :alert
  belongs_to :shift_opening, dependent: :destroy

  accepts_nested_attributes_for :shift_opening

  attribute :name, :capitalize_string

  validates :name, :alert, :team, :slug, :shift_opening, presence: true

  def today?
    shift_opening.on_day?(Time.current)
  end

  def in_progress?
    shift_opening.cover?(Time.current)
  end
end
