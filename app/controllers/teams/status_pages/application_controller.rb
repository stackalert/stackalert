# frozen_string_literal: true

module Teams
  module StatusPages
    class ApplicationController < ::Teams::ApplicationController
      before_action :find_status_page

      private

      def find_status_page
        @status_page = policy_scope(StatusPage).first
      end
    end
  end
end
