module Api
  module V1
    class PetitionsController < ApplicationController
      # GET /petitions
      # GET /petitions.json
      def index
        @petitions = Petition.where(QueryParams.new(Petition, params).build)

        render json: @petitions
      end

      # GET /petitions/1
      # GET /petitions/1.json
      def show
        @petition = Petition.friendly.find(params[:id])

        render json: @petition
      end

      # POST /petitions
      # POST /petitions.json
      def create
        @petition = Petition.new(petition_params)

        if @petition.save
          render json: @petition, status: :created,
            location: api_v1_petition_path(@petition)
        else
          render_validation_errors @petition.errors
        end
      end

      # PATCH/PUT /petitions/1
      # PATCH/PUT /petitions/1.json
      def update
        @petition = Petition.friendly.find(params[:id])

        authorize! :manage, @petition
        if @petition.update(petition_params)
          head :no_content
        else
          render_validation_errors @petition.errors
        end
      end

      # DELETE /petitions/1
      # DELETE /petitions/1.json
      def destroy
        @petition = Petition.friendly.find(params[:id])

        authorize! :manage, @petition
        
        @petition.destroy

        head :no_content
      end

      private
      def petition_params
        params.require(:petition).permit(:title, :body, :goal, :delivery_date,
          :deliver_to, :initiative_id).merge(creator: current_user)
      end
    end
  end
end