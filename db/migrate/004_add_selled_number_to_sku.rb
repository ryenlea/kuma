class AddSelledNumberToSku < ActiveRecord::Migration
  def self.up
    add_column :product_skus, :selled_number, :integer, default: 0
  end

  def self.down
    remove_column :product_skus, :selled_number
  end
end
