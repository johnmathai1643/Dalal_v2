module ApiHelper
	def check_credentials!
		u = User.find_by_email(request.headers["X-DALAL-API-EMAIL"])
		if !u or !u.valid_password?(request.headers["X-DALAL-API-PASSWORD"])
			render :json => { auth_error: true }
		else
			@cur_user = u
		end
	end
end
