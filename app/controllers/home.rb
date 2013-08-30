Kuma::App.controllers :home do
  get :index , :map => '/' do
  	render 'home/index', :layout => 'application'
  end

end
