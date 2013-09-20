# encoding: UTF-8
Kuma::App.controllers :home do
  
  get :index , map: '/' do
    session[:return_to] = nil
  	redirect '/login'
    #render 'home/index', :layout => 'application'
  end

  get :about_us, map: '/about_us' do
    render 'home/about_us'
  end
end
