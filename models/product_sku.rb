# encoding: UTF-8
class ProductSku < ActiveRecord::Base
  belongs_to :product
    
  validates :product_id,  :color, :size, :number , presence: true ,if: :validate_require?
  validates :color, :size, length: {maximum: 200},if: :validate_require?
  validates_numericality_of :number, only_integer: true, greater_than: 0, less_than: 9999  ,if: :validate_require?
  
  private
  def validate_require?
    color.present? || size.present? || number.present?
  end
end