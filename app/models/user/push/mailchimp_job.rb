# frozen_string_literal: true

class User
  module Push
    class MailchimpJob < ApplicationJob
      queue_as :low_priority

      def perform(user)
        user.push_to_mailchimp
      end
    end
  end
end
