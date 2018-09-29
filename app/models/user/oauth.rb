# frozen_string_literal: true

class User
  class Oauth
    def initialize(auth)
      @auth = auth
      @provider = @auth.provider
      @extractor = Extractor.load(@auth)
      @user = find_user
    end

    def sign_in_or_create
      registered? ? create_new_identity : (login || create_new_identity)
      @user
    end

    private

    def find_user
      UserIdentity.find_by(@extractor.signature).try(:user) || User.find_by(email: @extractor.email)
    end

    def registered?
      @user.present?
    end

    def login
      @user_identity = UserIdentity.where(@extractor.signature).first
      if @user_identity.present?
        refresh_tokens
        @user = @user_identity.user
      else
        false
      end
    end

    def create_new_identity
      create_new_user if @user.nil?

      return if identity_already_exists?
      @user_identity = @user.user_identities.create!(
        provider: @provider,
        uid: @extractor.uid,
        oauth_token:  @extractor.oauth_token,
        oauth_expires: @extractor.oauth_expires,
        oauth_secret: @extractor.oauth_secret
      )
    end

    def identity_already_exists?
      @user.user_identities.exists?(@extractor.signature)
    end

    def create_new_user
      @user = User.create!(
        name: @extractor.name,
        email: @extractor.email,
        confirmed_at: Time.current,
        bypass_confirmation: true,
        avatar_url: @extractor.avatar_url
      )
    end

    def refresh_tokens
      @user_identity.update_attributes(
        oauth_token: @extractor.oauth_token,
        oauth_expires: @extractor.oauth_expires,
        oauth_secret: @extractor.oauth_secret
      )
    end
  end
end
