# frozen_string_literal: true

class UserIdentity < ApplicationRecord
  acts_as_paranoid

  belongs_to :user

  validates :uid, :provider, :oauth_token, presence: true
  validates :uid, uniqueness: { scope: :provider }
end
