# frozen_string_literal: true

class Identity
  class GithubOrganizations
    def initialize(identity)
      @identity = identity
    end

    def fetch
      Rails.cache.fetch("#{@identity.token}/organizations", expires_in: 1.day) do
        client.organizations.map { |obj| GithubOrganization.new(obj) }
      end
    end

    private

    def client
      @client ||= Octokit::Client.new(access_token: @identity.token)
    end
  end
end
