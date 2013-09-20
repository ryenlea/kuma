# encoding: UTF-8
Kuma::App.controllers :order_items do
  layout :admin
  
	before do
    redirect "/login" unless user_login?
    $active_module = 'order_items'
	end
  
  delete :del_order_item, map:"/admin/p/:product_id/order_items/:order_item_id" do
    @product = current_user.products.find(params[:product_id])
    @product.order_items.find(params[:order_item_id]).cancel_reserve
    redirect "admin/activities/#{@product.activity_id}/report_flow"
  end
  
  get :list_reserve_his, map: '/admin/his_items' do
    @order_items = OrderItem.his_items(current_user.id)
    render "admin/order_items/index"
  end
end
