module Api
  module V1
    class EventsController < ApplicationController
      # GET /events
      # GET /events.json
      def index
        @events = FlexibleFeeds::Event.where(
          QueryParams.new(FlexibleFeeds::Event, params).build
        )

        render json: @events
      end

      # GET /events/1
      # GET /events/1.json
      def show
        @event = FlexibleFeeds::Event.find(params[:id])

        render json: @event
      end
    end
  end
end