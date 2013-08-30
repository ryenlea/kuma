Kuma::App.controllers 'product_skus' do
    parent :product, :map => 'admin/products'

    get :index  do
      "admin index"
    end

    get :show, :with => :product_sku_id, :map => '' do
    end

    delete :delete, :with => :product_sku_id, :map => '' do
    end
end
