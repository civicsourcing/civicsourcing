module Api
  module V1
    class Initiatives::FeaturesController < ApplicationController

      def create
        authorize! :set_feature, Initiative
        @initiative = Initiative.find(params[:id])
        @initiative.feature
      end
    end
  end
end