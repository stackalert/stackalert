# frozen_string_literal: true

module Teams
  class AlertsController < Teams::ApplicationController
    before_action :find_alert, only: %i[edit show update destroy]

    def index
      @alerts = policy_scope(Alert).order(:created_at)
      respond_to do |format|
        format.html { render :index }
        format.json { render json: @alerts }
      end
    end

    def new
      authorize Alert
      @alert = Alert.new
      respond_to :html
    end

    def create
      authorize Alert
      @alert = Current.team.alerts.build(alert_params)
      respond_to do |format|
        if @alert.save
          format.any(:js, :html) do
            redirect_to team_alerts_path(Current.team),
                        notice: 'Alert was successfully created.'
          end
          format.json { render :show, status: :created, location: @alert }
        else
          format.html { render :new }
          format.json { render json: @alert.errors, status: :unprocessable_entity }
          format.js { render :create }
        end
      end
    end

    def show
      respond_to do |format|
        format.html { render :show }
        format.json { render json: @alert, include: %i[alert_rules alert_channels], methods: :check_ids }
      end
    end

    def edit
      authorize @alert
      respond_to :html
    end

    def update
      authorize @alert
      respond_to do |format|
        if @alert.update_attributes(alert_params)
          format.any(:js, :html) do
            redirect_to team_alerts_path(Current.team),
                        notice: 'Alert was successfully updated.'
          end
          format.json { head :no_content }
        else
          format.html { render :edit }
          format.json { render json: @alert.errors, status: :unprocessable_entity }
          format.js { render :update }
        end
      end
    end

    def destroy
      authorize @alert
      @alert.destroy
      respond_to do |format|
        format.any(:js, :html) { redirect_to alerts_path, notice: 'Alert was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private

    def find_alert
      @alert = policy_scope(Alert).friendly.find(params[:id])
    end

    def alert_params
      params.require(:alert).permit(:name, :email, :endpoint,
                                    check_ids: [],
                                    alert_rules_attributes: %i[id name threshold _destroy],
                                    alert_channels_attributes: %i[id type email endpoint _destroy])
    end
  end
end
