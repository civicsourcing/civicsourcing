module Api
  module V1
    class MembershipRequestResponsesController < ApplicationController
      # GET /membership_request_responses
      # GET /membership_request_responses.json
      def index
        query = params.except(:action, :controller, :format)
        @membership_request_responses = MembershipRequestResponse.where(query)

        render json: @membership_request_responses,
          each_serializer: MembershipRequestResponseSerializer
      end

      # GET /membership_request_responses/1
      # GET /membership_request_responses/1.json
      def show
        @membership_request_response = MembershipRequestResponse.
          find(params[:id])

        render json: @membership_request_response
      end

      # POST /membership_request_responses
      # POST /membership_request_responses.json
      def create
        @membership_request_response = MembershipRequestResponse.
          new(membership_request_response_params)

        authorize! :create, @membership_request_response
        if @membership_request_response.save
          render json: @membership_request_response, status: :created
        else
          render_validation_errors @membership_request_response.errors
        end
      end

      private
      def membership_request_response_params
        params.require(:membership_request_response).permit(:accepted,
          :membership_request_id, :notes).merge(creator: current_user)
      end
    end
  end
end