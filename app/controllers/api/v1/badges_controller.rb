module Api
  module V1
    class BadgesController < ApplicationController
      # GET /badges
      # GET /badges.json
      def index
        @badges = params[:ids].collect{ |id| Merit::Badge.find id.to_i }

        render json: @badges
      end

      # GET /badges/1
      # GET /badges/1.json
      def show
        @badge = Merit::Badge.find(params[:id])

        render json: @badge
      end
    end
  end
end