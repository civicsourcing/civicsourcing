class Upload < ActiveRecord::Base
  mount_uploader :file, UploadUploader

  validates :file, presence: true

end