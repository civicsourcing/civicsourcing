module Api
  module V1
    class UsersController < ApplicationController

      def show
        render json: User.find(params[:id]), serializer: UserSerializer
      end

      def create
        @user = User.new(user_params)
        authorize! :create, @user
        @user.save
        if @user.save
          render json: @user, location: api_v1_dashboard_path, status: :created
        else
          render_validation_errors @user.errors
        end
      end

      private
      def user_params
        params.require(:user).permit(:email, :password, :password_confirmation,
          :username, :upload_id, :gender)
      end
     
    end
  end
end