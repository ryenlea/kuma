Kuma::App.controllers :activities, :map => 'admin/activities' do
	layout :admin
	
	before do
        redirect "/login" unless user_login?
	end
    
    get :index do
      "admin index"
    end

    get :show, :with => :activity_id, :map => '' do

    end
end
