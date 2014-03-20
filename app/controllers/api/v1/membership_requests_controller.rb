module Api
  module V1
    class MembershipRequestsController < ApplicationController
      # GET /membership_requests
      # GET /membership_requests.json
      def index
        query = params.except(:action, :controller, :format)
        @membership_requests = Adhocracy::MembershipRequest.where(query)

        render json: @membership_requests, each_serializer: MembershipRequestSerializer
      end

      # GET /membership_requests/1
      # GET /membership_requests/1.json
      def show
        @membership_request = Adhocracy::MembershipRequest.find(params[:id])

        render json: @membership_request
      end

      # POST /membership_requests
      # POST /membership_requests.json
      def create
        @membership_request = Adhocracy::MembershipRequest.new(membership_request_params)

        if @membership_request.save
          render json: @membership_request, status: :created, location: api_v1_membership_request_path(@membership_request)
        else
          render json: @membership_request.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /membership_requests/1
      # PATCH/PUT /membership_requests/1.json
      def update
        @membership_request = Adhocracy::MembershipRequest.find(params[:id])

        authorize! :manage, @membership_request
        if @membership_request.update(membership_request_params)
          head :no_content
        else
          render json: @membership_request.errors, status: :unprocessable_entity
        end
      end

      # DELETE /membership_requests/1
      # DELETE /membership_requests/1.json
      def destroy
        authorize! :manage, @membership_request
        @membership_request.destroy

        head :no_content
      end

      private
      def membership_request_params
        params.require(:membership_request).permit(:member_id, :member_type,
          :group_id, :group_type)
      end
    end
  end
end