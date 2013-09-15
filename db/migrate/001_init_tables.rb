class InitTables < ActiveRecord::Migration
  def self.up
  	create_table :users, :force => true do |t|
  		t.string :nickname, :limit => 16 , :null => false
  		t.string :email, :limit => 30, :null => false
  		t.string :password_digest, :limit => 128 ,:null => false
  		t.string :phone
  		t.string :reset_password_token
  		t.datetime :reset_password_send_at
  		t.datetime :remember_created_at
  		t.datetime :last_sign_in_at
  		t.datetime :current_sign_in_at
  		t.string :current_sign_in_ip
  		t.string :last_sign_in_ip
  		t.string :avatar
  		t.integer :role, default: 0
  		t.datetime :created_at
  		t.datetime :updated_at
  	end

  	#create_table :photos, :force => true do |t|
  	#	t.integer :category, :null => false
  	#	t.string :name
  	#	t.string :format
  	#	t.string :path
  	#	t.string :thumb_path
  	#	t.datetime :created_at
  	#end

  	create_table :activities, :force => true do |t|
  		t.string :name, :null => false
  		t.integer :user_id, :null => false
  		t.datetime :started_at 
  		t.datetime :ended_at
  		t.datetime :created_at
  		t.datetime :updated_at
  	end

  	create_table :products, :force => true do |t|
  		t.string :name, :null => false
  		t.text :description
  		t.string :purchase_price
  		t.string :sell_price
  		t.string :taobao_link
  		t.string :product_link
  		t.integer :user_id, :null => false
  		t.integer :activity_id
  		t.string :photo
  		t.datetime :created_at
  		t.datetime :updated_at
  	end

  	create_table :product_skus, :force => true do |t|
  		t.integer :product_id, :null => false
  		t.string :color
  		t.string :size
  		t.integer :number
  		t.datetime :created_at
  		t.datetime :updated_at
  	end

  	create_table :order_items, :force => true do |t|
  		t.integer :product_id, :null => true
  		t.integer :product_sku_id, :null => true
  		t.integer :number
  		t.integer :buyer_id, :null => false
  		t.string :buyer_name
  		t.datetime :created_at
  		t.datetime :updated_at
  	end

  create_table :authentication, :force => true do |t|
    t.string :provider
    t.string :uid
    t.integer :user_id
    t.timestamp
  end

  end

  def self.down
  	drop_table :users
  	#drop_table :photos
  	drop_table :activities
  	drop_table :products
  	drop_table :product_skus
  	drop_table :order_items
  end
end
