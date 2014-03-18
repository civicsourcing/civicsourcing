module Api
  module V1
    class WorkroomsController < ApplicationController
      # GET /workrooms
      # GET /workrooms.json
      def index
        @workrooms = Workroom.where(QueryParams.new(Workroom, params).build)

        render json: @workrooms
      end

      # GET /workrooms/1
      # GET /workrooms/1.json
      def show
        @workroom = Workroom.find(params[:id])

        render json: @workroom
      end

      # POST /workrooms
      # POST /workrooms.json
      def create
        @workroom = Workroom.new(workroom_params)

        if @workroom.save
          render json: @workroom, status: :created
        else
          render json: @workroom.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /workrooms/1
      # PATCH/PUT /workrooms/1.json
      def update
        @workroom = Workroom.find(params[:id])

        if @workroom.update(workroom_params)
          head :no_content
        else
          render json: @workroom.errors, status: :unprocessable_entity
        end
      end

      # DELETE /workrooms/1
      # DELETE /workrooms/1.json
      def destroy
        @workroom = Workroom.find(params[:id])
        @workroom.destroy

        head :no_content
      end

      private
      def workroom_params
        params.require(:workroom).permit(:initiative_id)
      end
    end
  end
end