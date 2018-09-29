# frozen_string_literal: true

class TeamMember < ApplicationRecord
  acts_as_paranoid

  belongs_to :user
  belongs_to :team, counter_cache: true

  validates :team, :user, presence: true
end
