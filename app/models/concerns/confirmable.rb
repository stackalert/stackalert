# frozen_string_literal: true

module Concerns
  module Confirmable
    extend ActiveSupport::Concern

    included do
      attr_accessor :bypass_confirmation
      after_initialize :assign_confirm_attributes
      before_save :prepare_send_confirmation_instructions, if: :confirmation_required?
      after_commit :send_confirmation_instructions, if: :send_confirmation_instructions?
    end

    def confirm!
      self.email = unconfirmed_email
      self.unconfirmed_email = nil
      self.confirmed_at = Time.current
      self.confirmation_token = nil
      without_confirmation { save }
    end

    private

    def assign_confirm_attributes
      @send_confirmation_instructions = false
    end

    def without_confirmation
      @bypass_confirmation = true
      yield
      @bypass_confirmation = false
    end

    def send_confirmation_instructions?
      @send_confirmation_instructions
    end

    def confirmation_required?
      !@bypass_confirmation && email_changed? && !email.blank?
    end

    def prepare_send_confirmation_instructions
      @send_confirmation_instructions = true
      self.unconfirmed_email = email
      self.email = email_was if email_was.present?
      generate_confirmation_token
    end

    def generate_confirmation_token
      self.confirmation_token = friendly_token
      self.confirmation_sent_at = Time.current
    end

    def friendly_token(length = 20)
      rlength = (length * 3) / 4
      SecureRandom.urlsafe_base64(rlength).tr('lIO0', 'sxyz')
    end
  end
end
