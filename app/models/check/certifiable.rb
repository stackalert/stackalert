# frozen_string_literal: true

class Check
  module Certifiable
    extend ActiveSupport::Concern

    included do
      has_one :check_certificate, dependent: :destroy
    end

    def certify_later
      Check::SslJob.perform_later(id)
    end

    def certify
      Check::Ssl.new(self).run
    end
  end
end
