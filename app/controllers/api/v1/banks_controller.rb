module Api
  module V1
    class BanksController < ApplicationController

      # POST /banks
      # POST /banks.json
      def create
        @bank = Balanced::BankAccount.find(params[:uri])

        if @bank
          customer = current_user.find_or_register_customer(params)
          if customer.merchant_status == "underwritten"
            @bank.associate_to_customer(customer)
            customer.add_destination(@bank)
            render json: nil, status: :created
          else
            render json: {errors: { description: "Please provide the date of birth and postal code associated with this account." }}, status: 422
          end
        else
          render_validation_errors @bank.errors
        end
      end
    end
  end
end