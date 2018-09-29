# frozen_string_literal: true

class TeamsController < ApplicationController
  before_action :authenticated!
  before_action :find_team, only: %i[show edit update destroy]

  def index
    @teams = policy_scope(Team).order(:created_at)
    respond_to do |format|
      format.html { render :index }
      format.json { render json: @teams }
    end
  end

  def new
    @team = Team.new
    respond_to :html
  end

  def create
    @team = Team.join_or_create(team_params)

    respond_to do |format|
      if @team.persisted?
        format.json { render :show, status: :created, location: @team }
        format.any(:js, :html) { redirect_to team_checks_path(@team), notice: 'Team was successfully created.' }
      else
        format.html { render :new }
        format.json { render json: @team.errors, status: :unprocessable_entity }
        format.js { render :create }
      end
    end
  end

  def show
    respond_to do |format|
      format.html { render :show }
      format.json { render json: @team }
    end
  end

  def edit
    authorize @team
    respond_to :html
  end

  def update
    authorize @team
    respond_to do |format|
      if @team.update_attributes(team_params)
        format.any(:js, :html) { redirect_to @team, notice: 'Team was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :edit }
        format.json { render json: @team.errors, status: :unprocessable_entity }
        format.js { render :update }
      end
    end
  end

  def destroy
    authorize @team
    @team.destroy
    respond_to do |format|
      format.any(:js, :html) { redirect_to go_to_app_path, notice: 'Team was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def find_team
    Current.team = policy_scope(Team).friendly.find(params[:id])
    @team = Current.team
  end

  def team_params
    params.require(:team).permit(:name, :time_zone, :avatar, :avatar_url, :provider, :uid)
  end
end
