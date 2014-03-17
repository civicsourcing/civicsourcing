module Api
  module V1
    class VotesController < ApplicationController

      # POST /votes
      # POST /votes.json
      def create
        event = FlexibleFeeds::Event.find(params[:vote][:event_id])
        voter = params[:vote][:voter_type].constantize.
          find(params[:vote][:voter_id])
        vote = event.cast_vote({ voter: voter, value: params[:vote][:value] })
        render json: vote, status: :created
      end

      # GET /votes/1
      # GET /votes/1.json
      def show
        vote = FlexibleFeeds::Vote.find(params[:id])

        render json: vote
      end
    end
  end
end