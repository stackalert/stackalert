# frozen_string_literal: true

Rails.application.routes.draw do
  default_url_options host: Rails.application.credentials[Rails.env.to_sym][:host]

  scope constraints: Constraints::Html do
    get '/sign-out' => 'sessions#destroy', as: :sign_out
    scope '/auth' do
      get '/:provider/callback' => 'sessions#create'
      get '/failure' => 'sessions#failure'
    end
  end

  use_doorkeeper do
    controllers applications: 'oauth/applications', authorized_applications: 'oauth/authorized_applications'
  end

  scope constraints: Constraints::Application do
    resource :user, only: %i[edit update]

    resources :teams do
      scope module: :teams do
        resources :users
        resources :identities

        resources :checks do
          scope module: :checks do
            resources :charts, only: [] do
              collection do
                get 'history'
                get 'timeline'
              end
            end
          end
        end
        resources :check_configurations, only: [:create]
        resources :alerts
        resources :shifts
        resource :status_page, only: %i[edit update show] do
          scope module: :status_pages do
            resources :incidents
            resources :subscribers
          end
        end
      end
    end

    resources :browser_pushes, only: :create
  end

  scope constraints: Constraints::Html do
    resources :status_pages, only: :show do
      scope module: :status_pages do
        resources :subscribers, only: :create
      end
    end
  end

  namespace :team_identities do
    get '/slack/callback', to: 'callbacks#slack'

    get '/auth/:team_id/twitter', to: 'auths#twitter', as: 'auth_twitter'
    get '/twitter/callback', to: 'callbacks#twitter'
  end

  namespace :slacks do
    resource :event, only: [:create]
    resource :action, only: [:create]
  end

  namespace :confirmation do
    resource :alert_channels, only: :create
    resource :users, only: :create
  end

  mount Sidekiq::Web, at: '/worker'
end
