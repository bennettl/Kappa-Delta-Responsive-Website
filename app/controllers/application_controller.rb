class ApplicationController < ActionController::Base

	# For forem gem
	def forem_user
		current_member
	end
	helper_method :forem_user

	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

	# Include SessionsHelper functions to all controllers
	include SessionsHelper
end
