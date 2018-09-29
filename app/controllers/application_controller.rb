# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include Concerns::Authenticable
  include Concerns::Trackable
  include Concerns::Authorizable
  include Concerns::Deviceable
  include Concerns::SignIn
  include Concerns::GoToApp
  include Concerns::Resetable
end
