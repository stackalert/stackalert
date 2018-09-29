# frozen_string_literal: true

if Rails.env.production?
  Raven.configure do |config|
    config.dsn = Rails.application.credentials.sentry_dsn
  end
end
