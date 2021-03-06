class MainMailer < ActionMailer::Base

	 # Returns a contact us mail object with the params appended to it
	def contact_mail(params)
		first_name 	= params[:first_name]
		last_name 	=  params[:last_name]
		name 		= "#{first_name} #{last_name}"
		
		puts "ego  #{params[:email_to]}"
		case params[:email_to]
			when  "webmaster"
				to = "nathaniel.schier@gmail.com"
			when "president"
				to = "dbs02011@mymail.pomona.edu"
			when "board"
				to = "jaredmathismmb@gmail.com"
			else
				to = "kzw02011@mymail.pomona.edu"
		end

		from 		= name + "<" + params[:email_from] + ">"
		message_text 	= "The following message is sent from KD's Contact Form: \n\n #{name} says \n\n" + params[:message]
		# message_html 	= "The following message is sent from KD's Contact Form: <br /><br /> #{name} says  <br /><br />" + params[:message]

		mail(to: to, from: from, subject: 'KD Contact Form') do |format|
		  format.text { render plain:  message_text }
		  #format.html { render html:  message_html }
		end
	end

end
