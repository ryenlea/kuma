# encoding: UTF-8
Kuma::App.controllers "/buy" do
  layout :buy
  
  before :reserve_list, :reserve_details do
    session[:return_to] = request.url
  end
  
  get :reserve_list, map: '/buy/:token' do
    @activity = Activity.find_by_token(params[:token])
    @products = @activity.products.includes(:order_items).order('created_at desc')
    render 'buy/index'
  end

  get :reserve_details, map:'/buy/:token/:product_id' do
    @activity = Activity.find_by_token(params[:token])
    @product = Product.find_by_id_and_activity_id(params[:product_id], @activity.id)
    @order_item = OrderItem.new
    @his_items = OrderItem.find_his_items({ buyer_id: current_user.id, product_id: params[:product_id]})
    render 'buy/show'
  end
  
  get ':token/:product_id/check' do
    content_type "text/plain"
    # 1 redirct to login 2 show reserve dialog
    user_login? ? "2":"1"
  end
  
  post :do_reserve, map: '/buy/:token/:product_id' do
    content_type :js
    @order_item = OrderItem.new(params[:order_item])
    @order_item.buyer_id = current_user.id
    @order_item.buyer_name = current_user.email
    @order_item.product_id = params[:product_id]
    if @order_item.do_reserve
      {result: 'ok'}.to_json
    else
      { errors: @order_item.errors.as_json }.to_json
    end
  end
  
end
