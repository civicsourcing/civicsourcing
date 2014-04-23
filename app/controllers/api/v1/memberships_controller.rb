module Api
  module V1
    class MembershipsController < ApplicationController
      # GET /memberships
      # GET /memberships.json
      def index
        query = params.except(:action, :controller, :format)
        @memberships = Adhocracy::Membership.where(query)

        render json: @memberships, each_serializer: MembershipSerializer
      end

      # GET /memberships/1
      # GET /memberships/1.json
      def show
        @membership = Adhocracy::Membership.find(params[:id])

        render json: @membership
      end

      # POST /memberships
      # POST /memberships.json
      def create
        @membership = Adhocracy::Membership.new(membership_params)

        if @membership.save
          render json: @membership, status: :created, location: api_v1_membership_path(@membership)
        else
          render_validation_errors @membership.errors
        end
      end

      # PATCH/PUT /memberships/1
      # PATCH/PUT /memberships/1.json
      def update
        @membership = Adhocracy::Membership.find(params[:id])

        authorize! :manage, @membership

        if @membership.update(membership_params)
          head :no_content
        else
          render_validation_errors @membership.errors
        end
      end

      # DELETE /memberships/1
      # DELETE /memberships/1.json
      def destroy
        @membership = Adhocracy::Membership.find(params[:id])

        authorize! :manage, @membership
        @membership.destroy

        head :no_content
      end

      private
      def membership_params
        params.require(:membership).permit(:member_id, :member_type,
          :group_id, :group_type)
      end
    end
  end
end