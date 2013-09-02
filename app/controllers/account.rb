Kuma::App.controllers :account, :map => '' do
  layout :account

  get :sign_up do
    @user = User.new
  	render 'account/sign_up'
  end

  post :sign_up do
    @user = User.new(params[:account])
    @user.current_sign_in_ip = request.ip
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "sign up succ!"
      redirect '/admin'
    else
      render 'account/sign_up'
    end
  end

  get :login do
    render 'account/login'
  end

  post :login do
  	user = User.from_auth(env['omniauth.auth'])
  	session[:user_id] = user.id
  	flash[:notice] = "Welcome #{user.nickname}"
    redirect "/admin"
  end


  delete :logout do
    session["user_id"] = nil;
    flash[:notice] = 'logout succ!'
    redirect '/'
  end

end
