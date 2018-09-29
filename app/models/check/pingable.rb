# frozen_string_literal: true

class Check
  module Pingable
    extend ActiveSupport::Concern

    included do
      has_many :check_pings, dependent: :destroy
    end

    def on?(count:, state:)
      check_pings.count >= count &&
        check_pings.last(count).all? { |check_ping| check_ping.state == state } &&
        check_pings[-(count + 1)].try(:state) != state
    end

    def ping_history
      check_pings.last(100).map { |check_ping| [check_ping.created_at, check_ping.total_time] }
    end

    def ping_state
      check_ping_at(-1).state
    end

    def ping_total_time
      check_ping_at(-1).total_time
    end

    def ping_delta
      prev = check_ping_at(-1)
      older = check_ping_at(-2)
      return if prev.blank? || older.blank?

      prev.total_time - older.total_time
    end

    def ping_later
      Check::PingJob.perform_later(id)
    end

    def ping
      Check::Ping.new(self).perform
    end

    private

    def check_ping_at(position)
      check_pings[position] || CheckPing.new
    end
  end
end
