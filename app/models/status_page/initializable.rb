# frozen_string_literal: true

class StatusPage
  module Initializable
    extend ActiveSupport::Concern

    included do
      before_create :default_header
    end

    private

    def default_header
      return if header.present?

      self.header = <<~HEADER
        <h1>What is this site?</h1>
        <p>
          We continuously monitor the status of #{title}
          and all its related services. If there are any interruptions in service
          , a note will be posted here.
        </p>
      HEADER
    end
  end
end
