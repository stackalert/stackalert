# frozen_string_literal: true

class StatusPage < ApplicationRecord
  include PublicActivity::Model
  include StatusPage::Initializable
  include StatusPage::WatchCheckPing
  include StatusPage::Subscribable
  include StatusPage::Checkable

  acts_as_paranoid

  tracked owner: proc { |_, _| Current.user }

  has_paper_trail only: %i[title]

  belongs_to :team
  has_many :status_page_incidents, dependent: :destroy

  validates :title, :team, presence: true

  include FriendlyId
  friendly_id :title, use: :slugged
end
