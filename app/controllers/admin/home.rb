# encoding: UTF-8
Kuma::App.controllers 'admin' do
  layout :admin

  get :settings do
  	render 'admin/settings/profile'
  end
end
