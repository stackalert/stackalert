# frozen_string_literal: true

class TeamIdentity < ApplicationRecord
  include TeamIdentity::Slackable

  acts_as_paranoid

  belongs_to :team

  validates :uid, :provider, presence: true
  validates :uid, uniqueness: { scope: :provider }
end
