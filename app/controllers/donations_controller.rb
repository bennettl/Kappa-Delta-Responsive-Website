require 'stripe'

class DonationsController < ApplicationController
	# force_ssl unless Rails.env.development?

	def index
		@donations = Donation.all
	end

	def new
		@donation = Donation.new
	end
	
	def create
		@donation = Donation.find_by(email: params[:donation][:email])
		
		# If donation exists (identified by email), then update it, else create a new one
		if !@donation.nil?
			update_amount params[:donation][:amount].to_i
		else
			# Create a new donation
			@donation 	= Donation.new(donation_params)
			token 		= params[:stripeToken]
			currency	= helpers.number_to_currency @donation.amount, precision: 0
			email		= params[:donation][:email]

			# Create a Customer
			customer = Stripe::Customer.create(
			  :card => token,
			  :description => email,
			  :email => email
			)

			# Charge the Customer instead of the card
			Stripe::Charge.create(
			    :amount => @donation.amount * 100, # in cents
			    :currency => "usd",
			    :customer => customer.id
			)
	
			# Save a new donation record
			if @donation.save
				flash.now[:success] = "Donation of #{currency} received"

				# save the customer ID in your database so you can use it later
				@donation.update_attribute(:stripe_customer_id, customer.id)

				# If user is signed in, update the donation member_id attribute to include current_user
				if signed_in?
					puts "user is signed in"
					@donation.update_attribute(:member_id, current_member.id)			
				end
			else
				flash.now[:error] = "Something went wrong with donation creation"
			end
			
		end

		render 'new'
	end

	# Destroy all reocurring donations by user
	def destroy
		current_member.donations.where(reoccur: true).destroy_all
		flash[:success] = 'Donation Sucessfully Removed'
		redirect_to edit_member_path(current_member)
	end

	# Update existing donation with amount
	def update_amount(new_amount)
		# Need to do this because charge_card will charge the amount on donation
		token 				= params[:stripeToken]
		old_amount 			= @donation.amount
		@donation.amount	= new_amount
		
		# Charge the card
		charge_card(token, @donation)
		amount 		= old_amount + new_amount
		currency 	= helpers.number_to_currency amount, precision: 0

		# Update donation amount
		if @donation.update_attribute('amount', amount)
			flash.now[:success] = "Donation updated to #{currency}"
		else
			flash.now[:error] = "Something went wrong with update"
		end
	end
	
	# Base on the stripe token and donation object, charge the customer
	def charge_customer(token, donation)
		

		# See if the user has
	end

	# Base on the stripe token and donation object, charge the card
	def charge_card(token, donation)
		# Stripe calculates 425 number as $4.25, need to multiply donation amount by 100
		# Stripe::Charge.create(amount: donation.amount * 100, currency: 'usd', card: token, description: "test this out 0" )
	end
	
	# Strong parameters
	def donation_params
		params.require(:donation).permit(:amount, :email, :first_name, :last_name, :visible, :reoccur, :frequency)
	end

	# Make helper function accessible outside of views
	def helpers
		ActionController::Base.helpers
	end


end
