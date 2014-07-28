module SessionsHelper

	# Sign in member by creating a new remember token, store it in cookie and encrpyted version on database
	def sign_in(member)
		remember_token 						= Member.new_remember_token
		cookies.permanent[:remember_token] 	= remember_token
		member.update_attribute(:remember_token, Member.encrypt(remember_token))
		self.current_member = member
	end

	# Is the member signed in? Calling this function within a view, or other controllers.
	def signed_in?
		!self.current_member.nil?
	end

	# Sign member out by replacing member's remember token in dabatse with a random one and delete remember token in cookie
	def sign_out
		# Make a random remember token in case member cookie is every stolen
		randomRememberToken = Member.new_remember_token
		current_member.update_attribute(:remember_token, Member.encrypt(randomRememberToken))
		# Delete remember token from cookies and set member to nil
		cookies.delete(:remember_token)
		self.current_member = nil
	
	end

	# Set instance variable () to member
	def current_member=(member)
		@current_member = member
	end

	# is the current member admin
	def is_admin?
		if signed_in?
			(current_member.member_type == 'admin')
		else
			false
		end

	end

	# When retriving current member, grab session token from cookie and see if member exists in database
	def current_member
		encrypted_remember_token = Member.encrypt(cookies[:remember_token])
		@current_member ||= Member.find_by(remember_token: encrypted_remember_token) #only calls find_by when @current_member is nil
	end

	# See if current member is the same as member
	def current_member?(member)
		current_member == member
	end

	 # Redirects non signed in member with notice assigned to flash[:notice]
    def sign_in_member
        # If member is not signed in, store the location and redirect to sign in page
        unless signed_in?
            store_location
            redirect_to(signin_url, notice: 'Please sign in yo')
        end
    end

	# Friendly forwarding

	# Redirect the member back to the sessios[:return_to] or default
	def redirect_back_or(default)
		redirect_to(session[:return_to] || default)
		session.delete(:return_to)
	end

	# Store location of url in session[:return_to]
	def store_location
		# Only store URL if its a get request
		session[:return_to] = request.url if request.get?
	end
end

































