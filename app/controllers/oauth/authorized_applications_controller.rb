# frozen_string_literal: true

module Oauth
  class AuthorizedApplicationsController < Doorkeeper::AuthorizedApplicationsController
    include Concerns::Authenticable
    include Concerns::Authorizable
    include Concerns::Deviceable
    include Concerns::GoToApp

    layout 'application'
  end
end
