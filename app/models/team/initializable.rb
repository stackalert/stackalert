# frozen_string_literal: true

class Team
  module Initializable
    extend ActiveSupport::Concern

    included do
      after_create :create_defaults
    end

    private

    def create_defaults
      build_check.save!
      build_status_page(title: name).save!
    end

    def after_add_user(user)
      build_alert(user)
      add_role(user)
    end

    def add_role(user)
      if users.count.zero?
        user.add_role('Owner', self)
        user.add_role('Writer', self)
      else
        user.add_role('Reader', self)
      end
    end

    def build_alert(user)
      @build_alert ||= alerts.build(name: "#{user.name}'s Email").tap do |alert|
        alert.alert_rules.build(name: :danger, threshold: 10)
        alert.alert_channels.build(email: user.email,
                                   confirmed_at: Time.current,
                                   type: 'AlertChannelEmail',
                                   bypass_confirmation: true)
      end
    end

    def build_check
      @build_check ||= checks.build(
        name: 'Google',
        endpoint: 'https://www.google.com',
        every: 1,
        warning_threshold: 1000,
        danger_threshold: 2000
      )
    end
  end
end
