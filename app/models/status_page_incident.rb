# frozen_string_literal: true

class StatusPageIncident < ApplicationRecord
  acts_as_paranoid

  belongs_to :status_page, counter_cache: true
  belongs_to :user

  validates :user, :status_page, :severity, presence: true
  validates :body, length: { minimum: 2, maximum: 10_000 }

  enum severity: %i[enquiry minor major critical]
end
