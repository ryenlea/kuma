Kuma::App.controllers :activities, :map => 'admin/activities' do
	layout :admin
	
	before do
        redirect "/login" unless user_login?
	end
    
    get :index do
        @activities = Activity.all
        @activities_number = 0
        render "admin/activities/index"
    end

    get :new do
        @activity = Activity.new
        render "admin/activities/new"
    end

    post :create , map: '' do

    end

    get :edit, :map => ':activity_id/edit' do
        @activity = Activity.find(params[:activity_id])
        render "admin/activities/edit"
    end

    put :update, :map => ':activity_id' do
    end

    delete :delete, :map => ':activity_id' do
    end
end
