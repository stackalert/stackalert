# frozen_string_literal: true

module StatusPages
  class ApplicationController < ::ApplicationController
    layout 'status_page'

    before_action :find_status_page

    private

    def find_status_page
      @status_page = StatusPage.friendly.find(params[:status_page_id])
    end
  end
end
