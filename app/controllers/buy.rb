Kuma::App.controllers :buy do
  
  get :index, :with => :id do
  	render 'buy/index'
  end

end
