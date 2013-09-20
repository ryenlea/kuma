# encoding: UTF-8
Kuma::App.controllers 'admin/users' do
  layout :admin

  before do
  	halt 403 unless user_admin?
    $active_module = 'users'
  end

  get :index do
    @users = User.order('id DESC').page(params[:page])
    render "admin/users/index"
  end

  put ':user_id/reset_password' do
    @user = User.find(params[:user_id])
    @user.password = "000000"
    @user.password_confirmation = "000000"
    if @user.reset_password
        flash[:notice] = "成功把密码重置为000000"
    else
        flash[:notice] = "密码重置失败"
    end
    redirect "admin/users"
  end


  put ':user_id/change_role/:user_role' do
    ROLE = Hash.new(0)
    ROLE["1"] = 1
    user = User.find(params[:user_id])
    if user.update_attribute("role", ROLE[params[:user_role]])
        flash[:notice] = "角色修改成功"
    else
        flash[:notice] = "角色修改失败"
    end
  	redirect '/admin/users'
  end
end
