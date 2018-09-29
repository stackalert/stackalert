# frozen_string_literal: true

class Team < ApplicationRecord
  include PgSearch
  include Concerns::Avatarable
  include Team::Identifiable
  include Team::Initializable
  include Team::WatchCheckPing

  pg_search_scope :search, against: [:name], using: {
    tsearch: { prefix: true, any_word: true }
  }

  acts_as_paranoid

  resourcify

  has_paper_trail only: %i[name time_zone]

  include FriendlyId
  friendly_id :name, use: :slugged

  has_many :checks, dependent: :destroy
  has_many :shifts, dependent: :destroy
  has_many :alerts, dependent: :destroy
  has_many :team_members, dependent: :destroy
  has_many :users, through: :team_members, after_add: :after_add_user
  has_one :status_page, dependent: :destroy

  attribute :name, :capitalize_string

  validates :name, :users, :time_zone, :slug, presence: true
  validates :name, length: { minimum: 3, maximum: 30 }
  validates :time_zone, inclusion: { in: ActiveSupport::TimeZone.all.map(&:name) }
end
