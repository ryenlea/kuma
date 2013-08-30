Kuma::App.controllers 'admin/users' do
  
  get :index do
    "admin index"
  end

  post :update, :with => :id, :map => '' do
  end
end
