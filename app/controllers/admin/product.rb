Kuma::App.controllers :products do
	parent :activity, :optional => true, :map => 'admin/activities'

    get :index do
      "admin index"
    end

    get :show, :with => :product_id, :map => '' do
  	  ""
    end
end
