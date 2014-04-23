module Api
  module V1
    class PetitionSignaturesController < ApplicationController
      # GET /petition_signatures
      # GET /petition_signatures.json
      def index
        @petition_signatures = PetitionSignature.where(QueryParams.new(PetitionSignature, params).build)

        render json: @petition_signatures
      end

      # GET /petition_signatures/1
      # GET /petition_signatures/1.json
      def show
        @petition_signature = PetitionSignature.find(params[:id])

        render json: @petition_signature
      end

      # POST /petition_signatures
      # POST /petition_signatures.json
      def create
        @petition_signature = PetitionSignature.new(petition_signature_params)

        if @petition_signature.save
          render json: @petition_signature, status: :created,
            location: api_v1_petition_signature_path(@petition_signature)
        else
          render_validation_errors @petition_signature.errors
        end
      end

      # PATCH/PUT /petition_signatures/1
      # PATCH/PUT /petition_signatures/1.json
      def update
        @petition_signature = PetitionSignature.find(params[:id])

        authorize! :manage, @petition_signature
        if @petition_signature.update(petition_signature_params)
          head :no_content
        else
          render_validation_errors @petition_signature.errors
        end
      end

      # DELETE /petition_signatures/1
      # DELETE /petition_signatures/1.json
      def destroy
        @petition_signature = PetitionSignature.find(params[:id])

        authorize! :manage, @petition_signature
        
        @petition_signature.destroy

        head :no_content
      end

      private
      def petition_signature_params
        params.require(:petition_signature).permit(:petition_id, :comment).
          merge(user: current_user)
      end
    end
  end
end