# encoding: UTF-8
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

  get 'update_password' do
    render 'admin/profile/update_password'
  end

  put 'update_password' do
    @user = User.find(current_user.id)
    @user.attributes = {
      password: params[:password], 
      password_confirmation: params[:password_confirmation],
      current_password: params[:current_password]
    }
    if @user.update_password
      flash[:notice] = 'ok'
    else
      flash[:error] = 'update password err'
    end
    redirect '/admin/profile/update_password'
  end
end
