# frozen_string_literal: true

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github,
           Rails.application.credentials[Rails.env.to_sym][:github_app_id],
           Rails.application.credentials[Rails.env.to_sym][:github_app_secret],
           scope: 'user,read:org'
  provider :bitbucket,
           Rails.application.credentials[Rails.env.to_sym][:bitbucket_app_id],
           Rails.application.credentials[Rails.env.to_sym][:bitbucket_app_secret],
           scoper: 'email'
end
