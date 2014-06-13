class StaticPagesController < ApplicationController

	# Send the contact us message and redirect user
	def contact_send
		MainMailer.contact_mail(params).deliver
		flash[:success] = "Message was successfully sent!"
		redirect_to '/contact'
	end

end
