# encoding: UTF-8
class OrderItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :product
  belongs_to :product_sku

  validates :number, :product_id, :product_sku_id, presence: true
  validates_numericality_of :number, only_integer: true, greater_than: 0, less_than: 9999
  validate :reserve_number_should_less_or_equal_than_sku_number
  
  def do_reserve
    unless number
      errors.add(:number, "不能为空")
      return
    end 
    self.transaction do 
      product_sku = ProductSku.find(product_sku_id)
      product_sku.selled_number += number 
      product_sku.save
      save
    end
  end
  
  def cancel_reserve
    self.transaction do
      product_sku = ProductSku.find(product_sku_id)
      product_sku.selled_number -= number
      product_sku.save
      destroy
    end
  end
  
  def self.find_activity_report_flow options
    find_by_sql("select i.*, p.color,p.size , p.name as product_name\
                 from order_items i, \ 
                   (select product_skus.*, products.activity_id, products.name \
                    from product_skus left join products \
                    on product_skus.product_id = products.id) p \
                    where i.product_sku_id = p.id and p.activity_id = #{options[:activity_id]} order by created_at desc")
  end
  
  def self.find_activity_report options
    find_by_sql("select o.*, p.name as product_name, p.color, p.size \
                 from \
                 ( \
                  select buyer_id, buyer_name, product_id,product_sku_id, sum(number) as number \
                  from order_items group by buyer_id, product_id,product_sku_id \
                 ) o, \ 
                 ( \
                  select product_skus.*, products.activity_id, products.name \
                  from product_skus left join products \
                  on product_skus.product_id = products.id \
                  ) p \
                  where o.product_sku_id = p.id and p.activity_id = #{options[:activity_id]}")
  end
  
  def self.find_his_items options
    find_by_sql("select s.*, p.name as product_name \
                 from \
                 ( \
                   select oi.*, skus.color as product_color, skus.size as product_size \
                   from
                   (
                     select * from order_items where buyer_id = #{options[:buyer_id]} and product_id = #{options[:product_id]}
                   ) oi left join product_skus skus
                   on oi.product_sku_id = skus.id
                 ) s left join products p
                 on s.product_id = p.id order by s.created_at desc")
  end
  
  def self.his_items buyer_id
    find_by_sql("select s.*, p.name as product_name \
                 from \
                 ( \
                   select oi.*, skus.color as product_color, skus.size as product_size \
                   from
                   (
                     select * from order_items where buyer_id = #{buyer_id}
                   ) oi left join product_skus skus
                   on oi.product_sku_id = skus.id
                 ) s left join products p
                 on s.product_id = p.id order by s.created_at desc")
  end
  
  private
  def reserve_number_should_less_or_equal_than_sku_number
    unless number
      errors.add(:number, "不能为空")
      return false
    end 
    product_sku = ProductSku.find(product_sku_id)
    errors.add(:number, "库存不够") if (product_sku.number - product_sku.selled_number) < number
  end
end