# frozen_string_literal: true

class User < ApplicationRecord
  include PgSearch
  include Concerns::Avatarable
  include Concerns::Unsubscribable
  include Concerns::Confirmable
  include User::Marketable
  include User::Identifiable
  include User::Trackable

  pg_search_scope :search, against: %i[name email], using: {
    tsearch: { prefix: true, any_word: true }
  }

  acts_as_paranoid

  has_paper_trail only: %i[email name]

  include FriendlyId
  friendly_id :name, use: :slugged

  rolify role_join_table_name: :roles_users

  attribute :email, :downcase_string

  has_one :browser_push, dependent: :destroy
  has_many :access_grants, class_name: 'Doorkeeper::AccessGrant', foreign_key: :resource_owner_id, dependent: :destroy
  has_many :access_tokens, class_name: 'Doorkeeper::AccessToken', foreign_key: :resource_owner_id, dependent: :destroy
  has_many :oauth_applications, class_name: 'Doorkeeper::Application', as: :owner, dependent: :destroy
  has_many :team_members
  has_many :teams, through: :team_members

  validates :email, :name, presence: true
  validates :name, length: { minimum: 2, maximum: 30 }
  validates :email, length: { minimum: 2, maximum: 100 }
  validates :email, email: true

  def send_confirmation_instructions
    UserMailer.with(user: self, token: confirmation_token)
              .confirmation_instructions
              .deliver_later
  end
end
