# frozen_string_literal: true

class Alert < ApplicationRecord
  include PgSearch
  include PublicActivity::Model

  include Alert::WatchCheckPing
  include Alert::Triggerable

  pg_search_scope :search, against: [:name], using: {
    tsearch: { prefix: true, any_word: true }
  }

  acts_as_paranoid

  tracked owner: proc { |_, _| Current.user }

  include FriendlyId
  friendly_id :name, use: :scoped, scope: :team

  has_paper_trail only: [:name]

  belongs_to :team, counter_cache: true
  has_and_belongs_to_many :checks
  has_many :shifts, dependent: :destroy
  has_many :alert_rules, dependent: :destroy
  has_many :alert_channels, dependent: :destroy

  accepts_nested_attributes_for :alert_rules, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :alert_channels, reject_if: :all_blank, allow_destroy: true

  attribute :name, :capitalize_string

  validates :name, :alert_rules, :alert_channels, :team, :slug, presence: true
  validates :name, length: { minimum: 2, maximum: 30 }
end
