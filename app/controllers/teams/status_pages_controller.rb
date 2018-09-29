# frozen_string_literal: true

module Teams
  class StatusPagesController < Teams::ApplicationController
    before_action :find_status_page, only: %i[edit show update]

    def show
      respond_to do |format|
        format.html { render :show }
        format.json { render json: @status_page }
      end
    end

    def edit
      authorize @status_page
      respond_to :html
    end

    def update
      authorize @status_page
      respond_to do |format|
        if @status_page.update_attributes(status_page_params)
          format.any(:js, :html) do
            redirect_to team_status_page_path(Current.team),
                        notice: 'Status Page was successfully updated.'
          end
          format.json { head :no_content }
        else
          format.html { render :edit }
          format.json { render json: @status_page.errors, status: :unprocessable_entity }
          format.js { render :update }
        end
      end
    end

    private

    def find_status_page
      @status_page = policy_scope(StatusPage).first
    end

    def status_page_params
      params.require(:status_page).permit(:title, :header, :footer, :domain_name, :subdomain, check_ids: [])
    end
  end
end
