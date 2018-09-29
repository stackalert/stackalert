# frozen_string_literal: true

class BrowserPushesController < ApplicationController
  before_action :authenticated!

  def create
    @browser_push = Current.user.build_browser_push(browser_push_params)

    respond_to do |format|
      if @browser_push.save
        format.json { render json: @browser_push, status: :created }
      else
        format.json { render json: @browser_push.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def browser_push_params
    params.require(:browser_push).permit(:endpoint, keys: %i[auth p256dh]).tap do |parameter|
      parameter[:auth] = parameter[:keys][:auth]
      parameter[:p256dh] = parameter[:keys][:p256dh]
      parameter.delete(:keys)
    end
  end
end
