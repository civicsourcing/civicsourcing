module Api
  module V1
    class CardsController < ApplicationController

      # POST /comments
      # POST /comments.json
      def create
        @card = Balanced::Card.find(params[:uri])

        if @card
          customer = current_user.find_or_register_customer(params)
          @card.associate_to_customer(customer)
          customer.add_source(@card)
          render json: nil, status: :created
        else
          render_validation_errors @card.errors
        end
      end
    end
  end
end