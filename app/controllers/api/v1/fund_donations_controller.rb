module Api
  module V1
    class FundDonationsController < ApplicationController
      # GET /fund_donations
      # GET /fund_donations.json
      def index
        @fund_donations = FundDonation.where(QueryParams.new(FundDonation, params).build)

        render json: @fund_donations
      end

      # GET /fund_donations/1
      # GET /fund_donations/1.json
      def show
        @fund_donation = FundDonation.find(params[:id])

        render json: @fund_donation
      end

      # POST /fund_donations
      # POST /fund_donations.json
      def create
        @fund_donation = FundDonation.new(fund_donation_params)

        if @fund_donation.save
          render json: @fund_donation, status: :created,
            location: api_v1_fund_donation_path(@fund_donation)
        else
          render_validation_errors @fund_donation.errors
        end
      end

      # PATCH/PUT /fund_donations/1
      # PATCH/PUT /fund_donations/1.json
      def update
        @fund_donation = FundDonation.find(params[:id])

        authorize! :manage, @fund_donation
        if @fund_donation.update(fund_donation_params)
          head :no_content
        else
          render_validation_errors @fund_donation.errors
        end
      end

      # DELETE /fund_donations/1
      # DELETE /fund_donations/1.json
      def destroy
        @fund_donation = FundDonation.find(params[:id])

        authorize! :manage, @fund_donation
        
        @fund_donation.destroy

        head :no_content
      end

      private
      def fund_donation_params
        params.require(:fund_donation).permit(:amount, :fund_id,
          :fund_reward_id).merge(user: current_user)
      end
    end
  end
end