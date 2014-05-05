module Api
  module V1
    class FundsController < ApplicationController
      # GET /funds
      # GET /funds.json
      def index
        @funds = Fund.where(QueryParams.new(Fund, params).build)

        render json: @funds
      end

      # GET /funds/1
      # GET /funds/1.json
      def show
        @fund = Fund.friendly.find(params[:id])

        render json: @fund
      end

      # POST /funds
      # POST /funds.json
      def create
        @fund = Fund.new(fund_params)

        if @fund.save
          render json: @fund, status: :created,
            location: api_v1_fund_path(@fund)
        else
          render_validation_errors @fund.errors
        end
      end

      # PATCH/PUT /funds/1
      # PATCH/PUT /funds/1.json
      def update
        @fund = Fund.friendly.find(params[:id])

        authorize! :manage, @fund
        if @fund.update(fund_params)
          head :no_content
        else
          render_validation_errors @fund.errors
        end
      end

      # DELETE /funds/1
      # DELETE /funds/1.json
      def destroy
        @fund = Fund.friendly.find(params[:id])

        authorize! :manage, @fund
        
        @fund.destroy

        head :no_content
      end

      def feature
        authorize! :set_feature, Fund
        @initiative = Fund.find(params[:id])
        @initiative.feature
      end

      private
      def fund_params
        params["fund"]["fund_rewards_attributes"] = params["fund"].delete "fund_rewards"
        params.require(:fund).permit(:goal, :stretch_goal, :end_date, :body,
          :title, :initiative_id, fund_rewards_attributes: [:_destroy, :id,
            :minimum_donation, :description, :limit] ).
          merge(creator: current_user)
      end
    end
  end
end