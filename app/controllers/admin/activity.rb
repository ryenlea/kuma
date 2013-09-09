Kuma::App.controllers :activities, map: '/admin/activities' do
	layout :admin
	
	before do
        redirect "/login" unless user_login?
	end
    
    get :index do
        @activities = Activity.where("1=1").page(params[:page])
        #@activities_count = 0
        render "admin/activities/index"
    end

    get :new do
        @activity = Activity.new
        render "admin/activities/new"
    end

    post :create , map: '' do
        @activity = current_user.activities.build(params[:activity])
        if @activity.save
            redirect "/admin/activities"
        else
            render url(:activities, :new)
        end
    end

    get '/:activity_id/edit' do
        @activity = current_user.activities.find(params[:activity_id])
        render "admin/activities/edit"
    end

    put '/:activity_id' do
        params[:user_id] = current_user.id
        @activity = Activity.select_activity(params)
        if @activity.update_attributes(params[:activity])
            flash[:notice] = 'update ok'
            redirect '/admin/activities'
        else
            render 'admin/activities/edit'
        end
    end

    delete '/:activity_id' do

    end
end
