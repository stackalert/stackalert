# frozen_string_literal: true

class CheckDomain < ApplicationRecord
  validates :raw, :valid_on, :valid_until, :registrar, :check, presence: true
  belongs_to :check, touch: true

  def expired?
    expire_in.negative?
  end

  def expire_in
    (valid_until - Date.current).to_i
  end
end
