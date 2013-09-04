Kuma::App.controllers :account, :map => '' do
  layout :account
  
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
    if @user = User.authenticate(params[:user], params[:password])
      session[:user_id] = @user.id
  	    flash[:notice] = "Welcome #{user.nickname}"
      redirect "/admin"
    else
      redirect 'account/login'
    end
  end


  delete :logout do
    session["user_id"] = nil;
    flash[:notice] = 'logout succ!'
    redirect '/'
  end

end
