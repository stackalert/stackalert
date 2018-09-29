# frozen_string_literal: true

module Oauth
  class ApplicationsController < Doorkeeper::ApplicationsController
    include Concerns::Authenticable
    include Concerns::Authorizable
    include Concerns::Deviceable
    include Concerns::GoToApp

    before_action :authenticated!
    before_action :set_application, only: %i[show edit update destroy]

    layout 'application'

    def index
      @applications = policy_scope(Doorkeeper::Application).order(:created_at).page params[:page]
      respond_to :html, :json
    end

    def create
      @application = Doorkeeper::Application.new(application_params)
      @application.owner = Current.user

      respond_to do |format|
        if @application.save
          format.any(:js, :html) { redirect_to oauth_applications_url, notice: 'Application was successfully created.' }
          format.json { render :show, status: :created, location: @alert }
        else
          format.html { render :new }
          format.json { render json: @application.errors, status: :unprocessable_entity }
          format.js { render :create }
        end
      end
    end

    def update
      respond_to do |format|
        if @application.update_attributes(application_params)
          format.any(:js, :html) { redirect_to oauth_applications_url, notice: 'Application was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render :edit }
          format.json { render json: @application.errors, status: :unprocessable_entity }
          format.js { render :update }
        end
      end
    end

    private

    def set_application
      @application = policy_scope(Doorkeeper::Application).find(params[:id])
    end
  end
end
