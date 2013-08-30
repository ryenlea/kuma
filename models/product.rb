class Product < ActiveRecord::Base
	has_many :product_skus
	belongs_to :activity
end