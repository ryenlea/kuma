Kuma::App.controllers :account, :map => '' do
  layout :account

  get :sign_up do
  	@identity = session[:identity]
  	#binding.pry if @identity 
    render 'account/sign_up'
  end

  get :login do
    render 'account/login'
  end

  post :login, :map => '/auth/identity/callback' do
  	user = User.from_auth(env['omniauth.auth'])
  	session[:user_id] = user.id
  	flash[:notice] = "Welcome #{user.nickname}"
  end

  get :auth_failure, :map => '/auth/failure' do
  	flash[:notice] = params[:messages]
  	redirect '/'
  end

  delete :logout do
  end

end
