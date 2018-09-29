# frozen_string_literal: true

# Be sure to restart your server when you modify this file.

server = Rails.application.credentials[Rails.env.to_sym][:redis_url] + '/session'
Rails.application.config.session_store :redis_store,
                                       key: '_stack_alert',
                                       servers: [server]
