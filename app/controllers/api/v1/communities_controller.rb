module Api
  module V1
    class CommunitiesController < ApplicationController
      # GET /communities
      # GET /communities.json
      def index
        order = params[:order] || "score DESC"
        limit = params[:limit] || "10"
        @communities = Community.where(QueryParams.new(Community, params).build).
          order(order).limit(limit)

        render json: @communities, each_serializer: CommunitySerializer
      end

      # GET /communities/1
      # GET /communities/1.json
      def show
        @community = Community.friendly.find(params[:id])

        render json: @community, serializer: CommunitySerializer
      end

      # POST /communities
      # POST /communities.json
      def create
        @community = Community.new(community_params)

        if @community.save
          render json: @community, status: :created,
            location: api_v1_community_path(@community)
        else
          render_validation_errors @community.errors
        end
      end

      # PATCH/PUT /communities/1
      # PATCH/PUT /communities/1.json
      def update
        @community = Community.friendly.find(params[:id])

        authorize! :manage, @community
        if @community.update(community_params)
          head :no_content
        else
          render_validation_errors @community.errors
        end
      end

      # DELETE /communities/1
      # DELETE /communities/1.json
      def destroy
        @community = Community.friendly.find(params[:id])

        authorize! :manage, @community
        @community.destroy

        head :no_content
      end

      private
      def community_params
        params.require(:community).permit(:name, :private, :upload_id,
          :community_category_id).merge(user: current_user)
      end
    end
  end
end