# frozen_string_literal: true

module Teams
  class ShiftsController < Teams::ApplicationController
    before_action :find_shift, only: %i[edit show update destroy]

    def index
      @shifts = policy_scope(Shift).order(:created_at)
      respond_to do |format|
        format.html { render :index }
        format.json { render json: @shifts }
      end
    end

    def new
      authorize Shift
      @shift = Shift.new(shift_opening: ShiftOpening.new)
      respond_to :html
    end

    def create
      authorize Shift
      @shift = Current.team.shifts.build(shift_params)

      respond_to do |format|
        if @shift.save
          format.any(:js, :html) do
            redirect_to team_shifts_path(Current.team),
                        notice: 'Shift was successfully created.'
          end
          format.json { render :show, status: :created, location: @shift }
        else
          format.html { render :new }
          format.json { render json: @shift.errors, status: :unprocessable_entity }
          format.js { render :create }
        end
      end
    end

    def show
      respond_to do |format|
        format.html { render :show }
        format.json { render json: @shift }
      end
    end

    def edit
      authorize @shift
      respond_to :html
    end

    def update
      authorize @shift
      respond_to do |format|
        if @shift.update_attributes(shift_params)
          format.any(:js, :html) do
            redirect_to team_shifts_path(Current.team),
                        notice: 'Shift was successfully updated.'
          end
          format.json { head :no_content }
        else
          format.html { render :edit }
          format.json { render json: @shift.errors, status: :unprocessable_entity }
          format.js { render :update }
        end
      end
    end

    def destroy
      authorize @shift
      @shift.destroy
      respond_to do |format|
        format.any(:js, :html) { redirect_to shifts_path, notice: 'Shift was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private

    def find_shift
      @shift = policy_scope(Shift).friendly.find(params[:id])
    end

    def shift_params
      params.require(:shift).permit(:name, :alert_id,
                                    shift_opening_attributes: [:id, :starts_at, :ends_at, :_destroy, days: []])
    end
  end
end
