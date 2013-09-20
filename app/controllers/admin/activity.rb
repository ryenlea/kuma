# encoding: UTF-8
Kuma::App.controllers :activities, map: '/admin/activities' do
	layout :admin
	
	before do
    redirect "/login" unless user_login?
    login_redirect unless user_saler?
    $active_module = 'activities'
	end
    
  get :index do
    @activities = current_user.activities.page(params[:page])
    #@activities_count = 0
    render "admin/activities/index"
  end

  get :show_report_flow, map: ':activity_id/report_flow' do
    @activity = current_user.activities.find(params[:activity_id])
    @order_items = OrderItem.find_activity_report_flow params
    
    render "admin/activities/report_flow"
  end
  
  get :show_report, map: ':activity_id/report' do
    @activity = current_user.activities.find(params[:activity_id])
    @order_items = OrderItem.find_activity_report params
    
    render "admin/activities/report"
  end
  
  get :add_report_flow, map: ':activity_id/report_flow/new' do
    @users = User.all
    @activity = current_user.activities.find(params[:activity_id])
    @products = @activity.products
    @order_item = OrderItem.new
    render "admin/activities/reports/new"
  end
  
  post :do_add_report_flow, map: ':activity_id/report_flow' do
    @order_item = OrderItem.new(params[:order_item])
    @order_item.buyer_name = User.find(@order_item.buyer_id).email
    if @order_item.do_reserve
      redirect "/admin/activities/#{params[:activity_id]}/report_flow"
    else
      @users = User.all
      @activity = current_user.activities.find(params[:activity_id])
      @products = @activity.products
      render "admin/activities/reports/new"
    end
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
    current_user.activities.find(params[:activity_id]).destroy
    redirect "/admin/activities"
  end
end
