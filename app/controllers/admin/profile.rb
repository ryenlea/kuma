Kuma::App.controllers :profile, map: '/admin/profile' do
  layout :admin

  before do
    redirect "/login" unless user_login?
  end

  get '' do
    @user = User.find(current_user.id)
    render 'admin/profile/edit'
  end

  put '' do
    @user = current_user
    params[:user].delete("id")
    @user.attributes = params[:user]

    if @user.save(validate: false)
      flash[:notice] = "ok"
    else
      flash[:notice] = 'error'
    end
    redirect "/admin/profile"
  end

  get 'reset_password' do
    render 'admin/profile/reset_password'
  end

  put 'reset_password' do
    redirect '/admin/profile/reset_password'
  end
end
