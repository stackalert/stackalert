# frozen_string_literal: true

class BrowserPush < ApplicationRecord
  belongs_to :user

  validates :endpoint, :p256dh, :auth, :user, presence: true
end
