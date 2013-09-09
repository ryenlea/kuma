Kuma::App.controllers 'admin/users' do
  before do
  	halt 403 unless user_admin?
  end

  get :index do
     render "admin/users/index"
  end

  put ':user_id/role' do
  	redirect '/admin/users'
  end
end
