# frozen_string_literal: true

require 'sidekiq/web'

Sidekiq.configure_server do |config|
  config.redis = { url: Rails.application.credentials[Rails.env.to_sym][:redis_url] }
end

Sidekiq.configure_client do |config|
  config.redis = { url: Rails.application.credentials[Rails.env.to_sym][:redis_url] }
end

if Rails.env.production?
  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    ActiveSupport::SecurityUtils.secure_compare(
      ::Digest::SHA256.hexdigest(username),
      ::Digest::SHA256.hexdigest(Rails.application.credentials[:private][:user_name])
    ) &
      ActiveSupport::SecurityUtils.secure_compare(
        ::Digest::SHA256.hexdigest(password),
        ::Digest::SHA256.hexdigest(Rails.application.credentials[:private][:password])
      )
  end
end
