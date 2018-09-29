# frozen_string_literal: true

class CheckConfiguration < ApplicationRecord
  include CheckConfiguration::Installable
  include PgSearch
  pg_search_scope :search, against: [:name], using: {
    tsearch: { prefix: true, any_word: true }
  }

  validates :name, :values, presence: true
  validates :name, uniqueness: true
  validates :name, length: { minimum: 2, maximum: 30 }
end
