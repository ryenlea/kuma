Kuma::App.controllers :buy, map: "/buy" do
  
  get :show,  map: ':id' do
  	render 'buy/show'
  end

end
