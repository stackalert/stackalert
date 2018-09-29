# frozen_string_literal: true

module StatusPages
  class SubscribersController < StatusPages::ApplicationController
    def create
      @subscriber = @status_page.status_page_subscribers.build(status_page_subscriber_params)
      if @subscriber.valid?
        @subscriber.save
        redirect_to @status_page, notice: 'You have been added to the mailing list!'
      else
        flash.alert = 'There is a problem with your email address!'
        render 'status_pages/show'
      end
    end

    private

    def status_page_subscriber_params
      params.require(:status_page_subscriber).permit(:email)
    end
  end
end
