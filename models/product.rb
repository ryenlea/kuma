class Product < ActiveRecord::Base
	has_many :product_skus
	belongs_to :activity
	belongs_to :user

	accepts_nested_attributes_for :product_skus,  allow_destroy: true

	validates :name, :user_id, :activity_id , presence: true

    mount_uploader :photo, PhotoUploader

end