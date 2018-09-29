# frozen_string_literal: true

class SubscriberMailer < ApplicationMailer
  def notify
    @subscriber = params[:subscriber]
    @status_page = params[:status_page]
    @check = params[:check]
    mail(to: @subscriber.email, subject: "[Stack Alert] #{@status_page.title} encounter a problem")
  end
end
