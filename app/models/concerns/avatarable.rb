# frozen_string_literal: true

module Concerns
  module Avatarable
    extend ActiveSupport::Concern

    included do
      attr_accessor :avatar_url
      has_one_attached :avatar
      before_create :attach_avatar, if: proc { |object| object.avatar_url.present? }
    end

    private

    def attach_avatar
      tempfile = Down.download(avatar_url, max_redirects: 10)
      avatar.attach(io: tempfile,
                    filename: tempfile.original_filename,
                    content_type: tempfile.content_type)
    end
  end
end
