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
    end
  end
end