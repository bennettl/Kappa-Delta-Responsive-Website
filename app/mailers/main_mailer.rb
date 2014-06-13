class MainMailer < ActionMailer::Base

	 # Returns a contact us mail object with the params appended to it
	def contact_mail(params)
		first_name 	= params[:first_name]
		last_name 	=  params[:last_name]
		name 		= "#{first_name} #{last_name}"
		to 			= params[:email_to]
		from 		= name + "<" + params[:email_from] + ">"
		message_text 	= "The following message is sent from KD's Contact Form: \n\n #{name} says \n\n" + params[:message]
		# message_html 	= "The following message is sent from KD's Contact Form: <br /><br /> #{name} says  <br /><br />" + params[:message]

		mail(to: to, from: from, subject: 'KD Contact Form') do |format|
		  format.text { render plain:  message_text }
		  #format.html { render html:  message_html }
		end
	end

end
