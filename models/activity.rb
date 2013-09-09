class Activity < ActiveRecord::Base
    has_many :products
    belongs_to :user

    validates :name, :started_at, :ended_at,:user_id , presence: true
    def self.select_activity(params)
    	    find(params[:activity_id])
    end

    def status
    		'running'
    end
    
end