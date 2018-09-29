# frozen_string_literal: true

class User
  class ExternalOrgs
    ExternalOrg = Struct.new(:id, :name, :avatar_url, :provider)

    def initialize(identity)
      @identity = identity
    end

    def fetch
      send "fetch_#{@identity.provider}"
    rescue NoMethodError
      []
    end

    def fetch_github
      Rails.cache.fetch("#{@identity.provider}/#{@identity.uid}/organizations", expires_in: 1.day) do
        fetch_github_orgs
      end
    end

    private

    def fetch_github_orgs
      github_client.organizations.map do |obj|
        ExternalOrg.new obj.id, obj.login, obj.avatar_url, @identity.provider
      end
    end

    def github_client
      @github_client ||= Octokit::Client.new(access_token: @identity.oauth_token)
    end
  end
end
