class Api::V1::UploadsController < ApplicationController

  def create
    upload = Upload.create(upload_params)
    render json: upload, serializer: UploadSerializer
  end

  def show
    render json: Upload.find(params[:id]), serializer: UploadSerializer
  end

  private
  def upload_params
    params.require(:upload).permit(:file)
  end
end