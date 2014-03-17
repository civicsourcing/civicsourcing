module Api
  module V1
    class EventJoinsController < ApplicationController
      # GET /event_joins
      # GET /event_joins.json
      def index
        @event_joins = FlexibleFeeds::EventJoin.where(
          QueryParams.new(FlexibleFeeds::EventJoin, params).build
        )

        render json: @event_joins
      end

      # GET /event_joins/1
      # GET /event_joins/1.json
      def show
        @event_join = FlexibleFeeds::EventJoin.find(params[:id])

        render json: @event_join
      end
    end
  end
end