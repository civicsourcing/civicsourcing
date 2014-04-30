module Api
  module V1
    class Fund::FeaturesController < ApplicationController

      def create
        authorize! :set_feature
        @initiative = Fund.find(params[:fund_id])
        @initiative.feature
      end

      def destroy
        authorize! :set_feature
        @initiative = Fund.find(params[:fund_id])
        @initiative.defeature
      end
    end
  end
end