Kuma::App.controllers :products, map: '/admin/products' do
	layout :admin

    before do
        redirect "/login" unless user_login?
        redirect "/admin" unless user_saler?
    end

    get :index do
      @activites = current_user.activities.all
      @products = current_user.products.page(params[:page])
      render 'admin/products/index'
    end

    get :new do
      @product = Product.new
    	  render 'admin/products/new'
    end

    post :create , map: '' do
      @product = current_user.products.build(params[:product])
      
      if @product.save
        redirect "/admin/products"
      else
        render 'admin/products/new'
      end
    end

    get ':product_id/edit' do
       @product = current_user.products.find(params[:product_id])
  	  render 'admin/products/edit'
    end

    put ':product_id' do
    end

    delete ':product_id' do
    end
end
