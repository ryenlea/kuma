Kuma::App.controllers 'admin/users' do
  layout :admin

  before do
  	halt 403 unless user_admin?
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
        flash[:notice] = "reset password to '000000' succ!"
    else
        flash[:error] = "reset password err or ur password already 000000?"
    end
    redirect "admin/users"
  end


  put ':user_id/change_role/:role_id' do
    @user = User.new
    @user.id = params[:user_id].to_i
    ROLE = Hash.new(0)
    ROLE["1"] = 1
    if @user.update_column(:role, ROLE[params[:role_id]])
        flash[:notice] = "changerole succ!"
    else
        flash[:error] = "change role err!"
    end
  	redirect '/admin/users'
  end
end
