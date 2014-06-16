class StaticPagesController < ApplicationController
	
	def home
		# Find three latest news article
		@news = News.limit(3).order("created_at DESC")
	end

	# Send the contact us message and redirect user
	def contact_send
		MainMailer.contact_mail(params).deliver
		flash[:success] = "Message was successfully sent!"
		redirect_to '/contact'
	end

end
