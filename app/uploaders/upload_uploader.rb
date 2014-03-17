# encoding: utf-8

class UploadUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  process :resize_and_pad => [200, 200]

  version :thumb do
    process :resize_to_fill => [30, 30]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

end