# encoding: UTF-8
Kuma::App.controllers :products, map: '/admin/products' do
	layout :admin

    before do
      redirect "/login" unless user_login?
      login_redirect unless user_saler?
    end

    get :index do
      @products = current_user.products.page(params[:page])
      render 'admin/products/index'
    end

    get :new do
      @activities = current_user.activities.all
      @product = Product.new
      @product.product_skus.build
    	render 'admin/products/new'
    end

    post :create , map: '' do
      @product = current_user.products.build(params[:product])
      if @product.save
        redirect "/admin/products"
      else
        @activities = current_user.activities.all
        render 'admin/products/new'
      end
    end

    get ':product_id/edit' do
      @product = current_user.products.find(params[:product_id])
      @activities = current_user.activities.all
  	  render 'admin/products/edit'
    end

    put ':product_id' do
      params[:user_id] = current_user.id
      @product = current_user.products.find(params[:product_id])
      
      if @product.update_attributes(params[:product])
        redirect "/admin/products"
      else
        @activities = current_user.activities.all
        render 'admin/products/edit'
      end
    end

    delete ':product_id' do
      current_user.products.find(params[:product_id]).destroy
      redirect "/admin/products"
    end
end
