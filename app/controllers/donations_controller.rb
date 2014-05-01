require 'stripe'

class DonationsController < ApplicationController
	force_ssl unless Rails.env.development?
	
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

			# Charge the card
			charge_card(token, @donation)

			# Save a new donation record
			if @donation.save
				flash.now[:success] = "Donation of #{currency} received"
			else
				flash.now[:error] = "Something went wrong with create action"
			end
		end

		render 'new'
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
	
	# Base on the stripe token and donation object, charge the card
	def charge_card(token, donation)
		# Stripe calculates 425 number as $4.25, need to multiply donation amount by 100
		Stripe::Charge.create(amount: donation.amount * 100, currency: 'usd', card: token, description: "test this out 0" )
	end
	
	# Strong parameters
	def donation_params
		params.require(:donation).permit(:amount, :email, :first_name, :last_name, :visible)
	end

	# Make helper function accessible outside of views
	def helpers
		ActionController::Base.helpers
	end


end
