# frozen_string_literal: true

module Teams
  module StatusPages
    class IncidentsController < Teams::StatusPages::ApplicationController
      def index
        @incidents = policy_scope(StatusPageIncident)
        respond_to do |format|
          format.html { render :index }
          format.json { render json: @incidents }
        end
      end
    end
  end
end
