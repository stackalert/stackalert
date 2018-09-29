# frozen_string_literal: true

class CheckCertificate < ApplicationRecord
  validates :valid_on, :valid_until, :issuer, :check, presence: true
  belongs_to :check, touch: true

  def expired?
    expire_in.negative?
  end

  def expire_in
    (valid_until - Date.current).to_i
  end
end
