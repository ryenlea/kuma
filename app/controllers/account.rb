Kuma::App.controllers :account, :map => '' do
  layout :account
  
  before :sign_up, :login do
    redirect "/admin" if user_login?
  end

  get :sign_up do
    @user = User.new
  	  render 'account/sign_up'
  end

  post :sign_up do
    @user = User.new(sign_up_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "sign up succ!"
      redirect '/admin'
    else
      render 'account/sign_up'
    end
  end

  get :login do
    @user = User.new
    render 'account/login'
  end

  post :login do
    @user = User.new(params[:user])
    if login_user = User.authenticate(@user.email, @user.password)
      session[:user_id] = login_user.id
      response.set_cookie('user', {:value => login_user.encrypt_cookie_value, :path => "/", :expires => 2.weeks.since, :httponly => true}) if params[:remember_me]
  	    flash[:notice] = "Welcome #{@user.nickname}"
      redirect "/admin"
    else
      render 'account/login'
    end
  end

  delete :logout do
    session["user_id"] = nil;
    flash[:notice] = 'logout succ!'
    redirect '/'
  end

end
