Kuma::App.controllers :search do
  
  get :index, :map => 'admin/search' do
    "admin index"
  end
end
