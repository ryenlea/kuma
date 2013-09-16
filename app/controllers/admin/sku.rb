# encoding: UTF-8
Kuma::App.controllers :skus do
    parent :product, :map => '/admin/products'

    get :index  do
      "admin index"
    end

    get :show, :with => :sku_id, :map => '' do
    end

    delete :delete, :with => :sku_id, :map => '' do
    end
end
