Kuma::App.controllers :photos do
  
  get :index do
    "admin index"
  end

  get :show, :with => :id, :map => '' do
  end
end
