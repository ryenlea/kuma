# encoding: UTF-8
class ProductSku < ActiveRecord::Base
  belongs_to :product
  has_many :order_items
    
  validates :product_id,  :color, :size, :number , presence: true ,if: :validate_require?
  validates :color, :size, length: {maximum: 200},if: :validate_require?
  validates_numericality_of :number, only_integer: true, greater_than: 0, less_than: 9999  ,if: :validate_require?
  validate :number_should_greater_or_equal_than_selled_number
  
  def desc
    "颜色:#{color} - 尺寸:#{size}  剩余库存:#{number-selled_number}"
  end
  private
  def validate_require?
    color.present? || size.present? || number.present?
  end
  
  def number_should_greater_or_equal_than_selled_number
    errors.add(:number, "进货数量需要大于等于卖出数量") if selled_number > number
  end
end