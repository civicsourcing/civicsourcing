module Api
  module V1
    class FeedsController < ApplicationController
      # GET /feeds
      # GET /feeds.json
      def index
        @feeds = FlexibleFeeds::Feed.where(
          QueryParams.new(FlexibleFeeds::Feed, params).build
        )

        render json: @feeds
      end

      # GET /feeds/1
      # GET /feeds/1.json
      def show
        @feed = FlexibleFeeds::Feed.find(params[:id])

        render json: @feed
      end
    end
  end
end