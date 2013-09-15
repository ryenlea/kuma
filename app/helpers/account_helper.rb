Kuma::App.helpers do
	def current_user
		return @current_user if @current_user
		return @current_user = User.where({id: session[:user_id]}).first if session[:user_id]
		if request.cookies['user'] && (@current_user = User.validate_cookie(request.cookies['user']))
			session[:user_id] = @current_user.id
			return @current_user
		end
	end

	def user_login?
		current_user ? true : false
	end

	def user_admin?
		current_user && current_user.admin? ? true : false
	end

	def user_saler?
		current_user && current_user.saler? ? true : false
	end

    #
    def login_redirect
        if user_admin?
            redirect "/admin/users"
        elsif user_saler?
            redirect "/admin/activities"
        else
            redirect "/admin"
        end
    end
    #
	def prepare_session_params
    	params[:user]['current_sign_in_ip'] = request.ip
    	#binding.pry
    	params[:user]
  	end

  	#
  	
end
