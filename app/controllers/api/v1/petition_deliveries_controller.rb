module Api
  module V1
    class PetitionDeliveriesController < ApplicationController
      # GET /petition_deliveries
      # GET /petition_deliveries.json
      def index
        @petition_deliveries = PetitionDelivery.where(QueryParams.new(PetitionDelivery, params).build)

        render json: @petition_deliveries
      end

      # GET /petition_deliveries/1
      # GET /petition_deliveries/1.json
      def show
        @petition_delivery = PetitionDelivery.find(params[:id])

        render json: @petition_delivery
      end
    end
  end
end