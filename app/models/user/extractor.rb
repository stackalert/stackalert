# frozen_string_literal: true

class User
  class Extractor
    class << self
      def load(auth)
        provider = auth['provider'].classify

        begin
          "User::Extractor::#{provider}".constantize.new(auth)
        rescue NameError
          raise "#{provider} is not a valid extractor!"
        end
      end
    end

    attr_reader :auth

    def initialize(auth)
      @auth = auth
    end

    def signature
      { provider: provider, uid: uid }
    end

    def uid
      auth['uid']
    end

    def provider
      auth['provider']
    end
  end
end
