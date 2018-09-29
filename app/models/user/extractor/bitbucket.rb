# frozen_string_literal: true

class User
  class Extractor
    class Bitbucket < User::Extractor
      def email
        auth['info']['email']
      end

      def avatar_url
        auth['info']['avatar']
      end

      def oauth_token
        auth['credentials']['token']
      end

      def oauth_expires; end

      def oauth_secret
        auth['credentials']['secret']
      end

      def name
        auth['info']['name']
      end
    end
  end
end
