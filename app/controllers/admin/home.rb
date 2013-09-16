# encoding: UTF-8
Kuma::App.controllers 'admin' do
  layout :admin

  get :index , map: '' do
  	current_user
  	render 'admin/home'
  end

  get :settings do
  	render 'admin/settings/profile'
  end
end
