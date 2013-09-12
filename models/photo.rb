class Photo < ActiveRecord::Base
  mount_uploader :photo, PhotoUploader
  validates_presence_of :photo

  belongs_to :product

end