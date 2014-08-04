
desc "This task is called by the Heroku scheduler add-on"
task :stripe_process_reocurring_donations => :environment do

	puts "Finding customers with reocurring donations ..."
	donations = Donation.where(reoccur: true)


	donations.each do |donation|
		# Last time the reocurring donation was updated
		time_span 	= ''

		# Set the time_span to compare
		case donation.frequency
			when "week"
				time_span = 1.week
			when "month"
				time_span = 1.month
			when "year"
				time_span = 1.year
			else
				# Invalid frequncy, return
				next 
		end

		# If the difference between current time and last update is less than time span (1 week, 1 month, 1 year), then skip
		if Time.now - donation.updated_at < time_span
			puts "#{donation.first_name} not charge, too soon"
			next
		end

		# Charge the user
		Stripe::Charge.create(
		    :amount => donation.amount * 100, # in cents
		    :currency => "usd",
		    :customer => donation.stripe_customer_id
		)
		# Update the latest donation date
		donation.update_attribute(:updated_at, Time.now)

		# Console output
		puts "Charged #{donation.first_name} $#{donation.amount}"
	end

  puts "Stripe Reocurring donations finished."
end
