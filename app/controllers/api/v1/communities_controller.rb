module Api
  module V1
    class CommunitiesController < ApplicationController
      # GET /communities
      # GET /communities.json
      def index
        @communities = Community.where(QueryParams.new(Community, params).build)

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
          @community.add_member(current_user)
          current_user.follow(@community.feed)
          render json: @community, status: :created,
            location: api_v1_community_path(@community)
        else
          render json: @community.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /communities/1
      # PATCH/PUT /communities/1.json
      def update
        @community = Community.friendly.find(params[:id])

        if @community.update(community_params)
          head :no_content
        else
          render json: @community.errors, status: :unprocessable_entity
        end
      end

      # DELETE /communities/1
      # DELETE /communities/1.json
      def destroy
        @community = Community.friendly.find(params[:id])
        @community.destroy

        head :no_content
      end

      private
      def community_params
        params.require(:community).permit(:name, :private, :upload_id)
      end
    end
  end
end