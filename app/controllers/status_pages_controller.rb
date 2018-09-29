# frozen_string_literal: true

class StatusPagesController < ApplicationController
  layout 'status_page'

  before_action :find_status_page

  def show
    @subscriber = @status_page.status_page_subscribers.build
  end

  def find_status_page
    @status_page = StatusPage.friendly.find(params[:id])
  end
end
