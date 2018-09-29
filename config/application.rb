# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module StackAlert
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.action_controller.default_url_options = { trailing_slash: true }

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', headers: :any, methods: %i[get post patch put delete options]
      end
    end

    GA.tracker = Rails.application.credentials[Rails.env.to_sym][:ga_tracker_id]

    config.action_mailer.default_url_options = { host: Rails.application.credentials[Rails.env.to_sym][:host] }

    config.time_zone = 'UTC'

    config.action_cable.mount_path = '/cable'

    config.to_prepare do
      ::Doorkeeper::AuthorizationsController.layout 'id'
    end
  end
end
