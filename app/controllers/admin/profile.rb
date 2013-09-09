Kuma::App.controllers :profile, map: '/admin/profile' do
  layout :admin

  before do
    redirect "/login" unless user_login?
  end

  get '' do
    current_user
    render 'admin/profile/edit'
  end

  post '' do
    render 'admin/settings/profile'
  end
end
