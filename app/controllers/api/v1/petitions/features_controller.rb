module Api
  module V1
    class Petitions::FeaturesController < ApplicationController

      def create
        authorize! :set_feature, Petition
        @initiative = Petition.find(params[:id])
        @initiative.feature
      end
    end
  end
end