# frozen_string_literal: true

module Teams
  module Checks
    class ApplicationController < ::Teams::ApplicationController
      before_action :find_check

      private

      def find_check
        @check = policy_scope(Check).friendly.find(params[:check_id])
      end
    end
  end
end
