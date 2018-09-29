# frozen_string_literal: true

class Check < ApplicationRecord
  include PgSearch
  include PublicActivity::Model

  include Check::Pingable
  include Check::Slackable
  include Check::Chartable
  include Check::Whoisable
  include Check::Certifiable
  include Check::Schedulable
  include Check::Burnable
  include Check::Renderable

  pg_search_scope :search, against: [:name], using: {
    tsearch: { prefix: true, any_word: true }
  }

  tracked owner: proc { |_, _| Current.user }

  acts_as_paranoid

  include FriendlyId
  friendly_id :name, use: :scoped, scope: :team

  has_paper_trail only: %i[name endpoint warning_threshold danger_threshold every]

  MIN_THRESHOLD = 10
  MAX_THRESHOLD = 10_000

  belongs_to :team, counter_cache: true
  belongs_to :status_page
  has_and_belongs_to_many :alerts

  attribute :name, :capitalize_string

  validates :warning_threshold, :danger_threshold, :name, :endpoint, :every, :slug, :team, presence: true
  validates :name, length: { minimum: 2, maximum: 30 }
  validates :endpoint, url: true
  validates :warning_threshold, numericality: { only_integer: true,
                                                greater_than: MIN_THRESHOLD,
                                                less_than: MAX_THRESHOLD }
  validates :danger_threshold, numericality: { only_integer: true,
                                               greater_than: proc { |check| check.warning_threshold },
                                               less_than: MAX_THRESHOLD }
  validates :every, numericality: { only_integer: true,
                                    greater_than: 0,
                                    less_than: 61 }
  include RankedModel
  ranks :row_order

  def endpoint_uri
    @endpoint_uri ||= URI.parse(endpoint)
  end
end
