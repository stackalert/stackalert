# frozen_string_literal: true

class Team
  module Identifiable
    extend ActiveSupport::Concern

    include Team::Slack::Channelable

    included do
      has_many :team_identities, dependent: :destroy
    end

    class_methods do
      def join_or_create(attributes)
        Registrar.new(attributes).join_or_create
      end
    end

    def bind_with_slack(code)
      ::Team::Slack::Bind.new(self, code).execute
    end

    def bind_with_twitter(access_token)
      ::Team::Twitter::Bind.new(self, access_token).execute
    end

    def twitter?
      team_identities.map(&:provider).include?('twitter')
    end

    def slack?
      team_identities.any?(&:slack?)
    end

    def bitbucket?
      team_identities.map(&:provider).include?('bitbucket')
    end

    def github?
      team_identities.map(&:provider).include?('github')
    end
  end
end
