# encoding: UTF-8
Kuma::App.controllers :account, map: '' do
  #layout :account
  
  before :sign_up, :login do
    login_redirect if user_login?
  end

  get :sign_up do
    @user = User.new
  	render 'account/sign_up', layout: false
  end

  post :sign_up do
    @user = User.new(prepare_session_params)
    if @user.save_when_create
      session[:user_id] = @user.id
      flash[:notice] = "sign up succ!"
      login_redirect
    else
      render 'account/sign_up', layout: false
    end
  end

  get :login do
    @user = User.new
    render 'account/login', layout: false
  end

  post :login do
    @user = User.new(params[:user])
    if login_user = User.authenticate(@user.email, @user.password)
      session[:user_id] = login_user.id
      response.set_cookie('user', {:value => login_user.encrypt_cookie_value, :path => "/", :expires => 2.weeks.since, :httponly => true}) if params[:remember_me]
  	  flash[:notice] = "欢迎你, #{@user.nickname}"
      login_redirect
    else
      flash[:notice] = "用户名或密码出错"
      render 'account/login', layout: false
    end
  end

  delete :logout do
    session["user_id"] = nil;
    current_user = nil;
    flash[:notice] = '退出成功'
    if request.referrer.include? '/buy'
      redirect request.referrer
    else
      redirect '/'
    end
  end

end
