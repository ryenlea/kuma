require 'digest'

class AddTokenToActivity < ActiveRecord::Migration
  def self.up
    add_column :activities, :token, :string, null: false
    
    Activity.reset_column_information
    def Activity.readonly_attributes; nil end
    
    Activity.find_each do |activity|
      activity.update_attribute :token, Digest::MD5.hexdigest("#{activity.id}-#{Time.now}") 
    end
  end

  def self.down
    remove_column :activities, :token
  end
end
