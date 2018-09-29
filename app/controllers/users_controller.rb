# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticated!
  before_action :find_user

  def edit
    authorize @user
    respond_to :html
  end

  def update
    authorize @user
    respond_to do |format|
      if @user.update_attributes(user_params)
        format.any(:js, :html) { redirect_to edit_user_path, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
        format.js { render :update }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :avatar, :avatar_url)
  end

  def find_user
    @user = Current.user
  end
end
