# frozen_string_literal: true

module Teams
  module StatusPages
    class SubscribersController < Teams::StatusPages::ApplicationController
      def index
        @subscribers = policy_scope(StatusPageSubscriber)
        respond_to do |format|
          format.html { render :index }
          format.json { render json: @subscribers }
        end
      end
    end
  end
end
