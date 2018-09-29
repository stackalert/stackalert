# frozen_string_literal: true

class User
  module Identifiable
    extend ActiveSupport::Concern

    included do
      has_many :user_identities, dependent: :destroy
    end

    class_methods do
      def sign_in_or_create(auth)
        User::Oauth.new(auth).sign_in_or_create.tap(&:track)
      end
    end

    def external_orgs
      user_identities.map do |identity|
        ExternalOrgs.new(identity).fetch
      end.flatten
    end

    def github?
      user_identities.map(&:provider).include?('github')
    end

    def bitbucket?
      user_identities.map(&:provider).include?('bitbucket')
    end
  end
end
