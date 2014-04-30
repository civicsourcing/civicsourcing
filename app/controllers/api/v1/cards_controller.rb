module Api
  module V1
    class CardsController < ApplicationController

      # POST /comments
      # POST /comments.json
      def create
        @card = Balanced::Card.find(params[:uri])

        if @card && @card.cvv_match == "yes" && @card.avs_street_match == "yes" && @card.avs_postal_match == "yes"
          customer = current_user.find_or_register_customer(params)
          if customer.merchant_status == "underwritten"
            @card.associate_to_customer(customer)
            customer.add_source(@card)
            render json: nil, status: :created
          else
            render json: {errors: { description: "Please provide the date of birth and postal code associated with this account." }}, status: 422
          end
        elsif @card.cvv_match == "no"
          render json: {errors: { description: "The CVV is invalid." }}, status: 422
        elsif @card.avs_street_match == "no" || @card.avs_postal_match == "no"
          render json: {errors: { description: "The address is invalid." }}, status: 422
        else
          render_validation_errors @card.errors
        end
      end
    end
  end
end