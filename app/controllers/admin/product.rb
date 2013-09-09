Kuma::App.controllers :products, map: '/admin/products' do
	layout :admin

    get :index do
      render 'admin/products/index'
    end

    get 'new' do
    	  render 'admin/products/new'
    end

    post ':product_id' do
    end

    get ':product_id/edit' do
  	  render 'admin/products/edit'
    end

    put ':product_id' do
    end


end
