class AddCounterToActivity < ActiveRecord::Migration
  def self.up
    add_column :activities, :products_count, :integer, default: 0
    
    Activity.reset_column_information
    def Activity.readonly_attributes; nil end
    
    Activity.find_each do |activity|
      activity.update_attribute :products_count, activity.products.length
    end
  end

  def self.down
    remove_column :activities, :products_count
  end
end
