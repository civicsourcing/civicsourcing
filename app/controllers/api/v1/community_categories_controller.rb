module Api
  module V1
    class CommunityCategoriesController < ApplicationController
      # GET /community_categories
      # GET /community_categories.json
      def index
        @community_categories = CommunityCategory.where(QueryParams.new(CommunityCategory, params).build)

        render json: @community_categories, each_serializer: CommunityCategorySerializer
      end

      # GET /community_categories/1
      # GET /community_categories/1.json
      def show
        @community_category = CommunityCategory.find(params[:id])

        render json: @community_category, serializer: CommunityCategorySerializer
      end

      # POST /community_categories
      # POST /community_categories.json
      def create
        @community_category = CommunityCategory.new(community_category_params)

        authorize! :manage, @community_category
        if @community_category.save
          render json: @community_category, status: :created,
            location: api_v1_community_category_path(@community_category)
        else
          render_validation_errors @community_category.errors
        end
      end

      # PATCH/PUT /community_categories/1
      # PATCH/PUT /community_categories/1.json
      def update
        @community_category = CommunityCategory.find(params[:id])

        authorize! :manage, @community_category
        if @community_category.update(community_category_params)
          head :no_content
        else
          render_validation_errors @community_category.errors
        end
      end

      # DELETE /community_categories/1
      # DELETE /community_categories/1.json
      def destroy
        @community_category = CommunityCategory.find(params[:id])

        authorize! :manage, @community_category
        @community_category.destroy

        head :no_content
      end

      private
      def community_category_params
        params.require(:community_category).permit(:name)
      end
    end
  end
end