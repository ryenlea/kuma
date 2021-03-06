# encoding: UTF-8
class Product < ActiveRecord::Base
	has_many :product_skus, dependent: :destroy, inverse_of: :product
  has_many :order_items
	belongs_to :activity, counter_cache: true
	belongs_to :user

	accepts_nested_attributes_for :product_skus,  allow_destroy: true, reject_if: ->(attr) { attr['color'].blank? && attr['size'].blank? && attr['number'].blank? }
  validates_associated :product_skus

	validates :name, :user_id, :activity_id , presence: true
  validates :name, :purchase_price , :sell_price , :taobao_link, :product_link, length: {maximum: 200}
  

  mount_uploader :photo, PhotoUploader

  def self.search params
    if params[:activity_id]
      where("activity_id = ?", params[:activity_id]).page(params[:page])
    else
      page(params[:page])
    end
  end
end