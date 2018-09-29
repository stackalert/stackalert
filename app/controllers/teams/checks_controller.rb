# frozen_string_literal: true

module Teams
  class ChecksController < Teams::ApplicationController
    before_action :find_check, only: %i[edit show update destroy]

    def index
      @checks = policy_scope(Check).order(:created_at)
      respond_to do |format|
        format.html { render :index }
        format.json { render json: @checks }
      end
    end

    def new
      authorize Check
      @check = Check.new
      respond_to :html
    end

    def create
      authorize Check
      @check = Current.team.checks.build(check_params)

      respond_to do |format|
        if @check.save
          format.any(:js, :html) do
            redirect_to team_checks_path(Current.team),
                        notice: 'Check was successfully created.'
          end
          format.json { render :show, status: :created, location: @check }
        else
          format.html { render :new }
          format.json { render json: @check.errors, status: :unprocessable_entity }
          format.js { render :create }
        end
      end
    end

    def show
      respond_to do |format|
        format.html { render :show }
        format.json do
          render json: @check,
                 include: %i[check_pings check_certificate check_certificate],
                 methods: :alert_ids
        end
      end
    end

    def edit
      authorize @check
      respond_to :html
    end

    def update
      authorize @check
      respond_to do |format|
        if @check.update_attributes(check_params)
          format.any(:js, :html) do
            redirect_to team_check_path(Current.team, @check),
                        notice: 'Check was successfully updated.'
          end
          format.json { head :no_content }
        else
          format.html { render :edit }
          format.json { render json: @check.errors, status: :unprocessable_entity }
          format.js { render :update }
        end
      end
    end

    def destroy
      authorize @check
      @check.destroy
      respond_to do |format|
        format.any(:js, :html) do
          redirect_to team_checks_path(Current.team),
                      notice: 'Check was successfully destroyed.'
        end
        format.json { head :no_content }
      end
    end

    private

    def find_check
      @check = policy_scope(Check).friendly.find(params[:id])
    end

    def check_params
      params.require(:check).permit(:name, :every, :endpoint, :warning_threshold, :danger_threshold, alert_ids: [])
    end
  end
end
