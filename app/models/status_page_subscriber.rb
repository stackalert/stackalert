# frozen_string_literal: true

class StatusPageSubscriber < ApplicationRecord
  include Concerns::Unsubscribable

  acts_as_paranoid

  belongs_to :status_page, counter_cache: true

  attribute :email, :downcase_string

  validates :email, presence: true
  validates :email, uniqueness: { scope: :status_page_id }
  validates :email, length: { minimum: 2, maximum: 100 }
  validates :email, email: true
end
