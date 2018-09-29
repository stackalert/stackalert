# frozen_string_literal: true

module Teams
  class CheckConfigurationsController < Teams::ApplicationController
    def create
      authorize CheckConfiguration
      @check_configuration = policy_scope(CheckConfiguration).find(params[:id])
      @check_configuration.install

      respond_to do |format|
        format.any(:js, :html) do
          redirect_to team_checks_path(Current.team),
                      notice: 'Pre configuration was successfully installed.'
        end
        format.json { head :no_content }
      end
    end
  end
end
