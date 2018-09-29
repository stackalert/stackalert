# frozen_string_literal: true

class User
  module Marketable
    extend ActiveSupport::Concern

    included do
      after_commit :push_to_mailchimp_later
      after_create_commit :send_welcome_later
    end

    def mailchimp_status
      opted_out? ? 'unsubscribed' : 'subscribed'
    end

    def push_to_mailchimp_later
      Push::MailchimpJob.perform_later(self)
    end

    def push_to_mailchimp
      return unless Rails.application.credentials.mailchimp_api_key

      mailchimp_client
        .lists(Rails.application.credentials[Rails.env.to_sym][:mailchimp_list_id])
        .members(mailchimp_member_id)
        .upsert(body: mailchimp_body)
    end

    def send_welcome_later
      UserMailer.with(user: self).welcome.deliver_later
    end

    private

    def mailchimp_body
      {
        email_address: email,
        status: mailchimp_status,
        merge_fields: { LNAME: name }
      }
    end

    def mailchimp_member_id
      Digest::MD5.hexdigest(email)
    end

    def mailchimp_client
      @mailchimp_client ||= Gibbon::Request.new(api_key: Rails.application.credentials.mailchimp_api_key)
    end
  end
end
