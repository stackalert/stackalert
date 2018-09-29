# frozen_string_literal: true

class User
  class Extractor
    class Github < User::Extractor
      def email
        auth['info']['email']
      end

      def avatar_url
        auth['info']['image']
      end

      def oauth_token
        auth['credentials']['token']
      end

      def oauth_expires; end

      def oauth_secret; end

      def name
        auth['info']['name'] || auth['info']['nickname']
      end
    end
  end
end
