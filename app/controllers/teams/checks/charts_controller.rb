# frozen_string_literal: true

module Teams
  module Checks
    class ChartsController < Teams::Checks::ApplicationController
      def history
        respond_to do |format|
          format.json { render json: @check.ping_history }
        end
      end

      def timeline
        check_ping = @check.check_pings.last
        respond_to do |format|
          format.json do
            render json: [
              ['Name Lookup Time', 0, check_ping.name_lookup_time / 1000.0],
              ['Connect Time', check_ping.name_lookup_time / 1000.0, check_ping.connect_time / 1000.0],
              ['App Connect Time', check_ping.connect_time / 1000.0, check_ping.app_connect_time / 1000.0],
              ['Start Transfer Time',
               check_ping.app_connect_time / 1000.0,
               check_ping.start_transfer_time / 1000.0],
              ['End Transfer Time', check_ping.start_transfer_time / 1000.0, check_ping.total_time / 1000.0]
            ]
          end
        end
      end
    end
  end
end
