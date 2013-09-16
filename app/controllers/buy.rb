# encoding: UTF-8
Kuma::App.controllers "/buy" do
  layout :application
  
  get ':token' do
    @activity = Activity.find_by_token(params[:token])
    @products = @activity.products
    render 'buy/index'
  end

  get ':token/:product_id' do
    @activity = Activity.find_by_token(params[:token])
    @product = Product.find_by_id_and_activity_id(params[:product_id], @activity.id)
    render 'buy/show'
  end
end
