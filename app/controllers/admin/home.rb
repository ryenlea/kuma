Kuma::App.controllers 'admin' do
  get :index , map: '' do
    render 'admin/home'
  end

  get :settings do
  end
end
