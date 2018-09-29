# frozen_string_literal: true

class CheckPing < ApplicationRecord
  include CheckPing::Observable

  belongs_to :check, counter_cache: true, touch: true

  validates :http_code, :name_lookup_time, :connect_time, :app_connect_time, :pre_transfer_time,
            :redirect_time, :start_transfer_time, :total_time, :check, :state, presence: true

  enum state: %i[success warning danger]
end
