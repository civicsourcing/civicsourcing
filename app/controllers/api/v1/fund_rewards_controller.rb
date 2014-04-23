module Api
  module V1
    class FundRewardsController < ApplicationController
      # GET /fund_rewards
      # GET /fund_rewards.json
      def index
        @fund_rewards = FundReward.where(QueryParams.new(FundReward, params).build)

        render json: @fund_rewards
      end

      # GET /fund_rewards/1
      # GET /fund_rewards/1.json
      def show
        @fund_reward = FundReward.find(params[:id])

        render json: @fund_reward
      end
    end
  end
end