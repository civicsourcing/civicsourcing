module Api
  module V1
    class InitiativesController < ApplicationController
      # GET /initiatives
      # GET /initiatives.json
      def index
        @initiatives = Initiative.where(QueryParams.new(Initiative, params).build)

        render json: @initiatives
      end

      # GET /initiatives/1
      # GET /initiatives/1.json
      def show
        @initiative = Initiative.friendly.find(params[:id])

        render json: @initiative
      end

      # POST /initiatives
      # POST /initiatives.json
      def create
        @initiative = Initiative.new(initiative_params)

        if @initiative.save
          render json: @initiative, status: :created,
            location: api_v1_initiative_path(@initiative)
        else
          render_validation_errors @initiative.errors
        end
      end

      # PATCH/PUT /initiatives/1
      # PATCH/PUT /initiatives/1.json
      def update
        @initiative = Initiative.friendly.find(params[:id])

        authorize! :manage, @initiative
        if @initiative.update(initiative_params)
          head :no_content
        else
          render_validation_errors @initiative.errors
        end
      end

      # DELETE /initiatives/1
      # DELETE /initiatives/1.json
      def destroy
        @initiative = Initiative.friendly.find(params[:id])

        authorize! :manage, @initiative
        
        @initiative.destroy

        head :no_content
      end

      def feature
        authorize! :set_feature, Initiative
        @initiative = Initiative.find(params[:id])
        @initiative.feature
      end

      private
      def initiative_params
        params.require(:initiative).permit(:name, :description, :community_id).
          merge(creator: current_user)
      end
    end
  end
end