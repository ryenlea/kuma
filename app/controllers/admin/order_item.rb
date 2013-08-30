Kuma::App.controllers :order_items do
	parent :activity, :map => 'admin/activities'

    get :index do
      "admin index"
    end
end
