class Activity < ActiveRecord::Base
    has_many :products

    def status
    		'running'
    end
    
end