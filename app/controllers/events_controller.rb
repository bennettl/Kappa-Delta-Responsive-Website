class EventsController < ApplicationController
	
	# Display list of all events
	def index
		@events = Event.all
	end

	# Display an existing event
	def show
		@event = Event.find(params[:id])
	end

	# Display form to create a new event
	def new 
		@event = Event.new
	end

	# Create a new event
	def create
	end

	# Display form to update an existing event
	def edit
		@event = Event.find(params[:id])
	end 

	# Update an existing event
	def update
	end

	# Remove an existing event
	def destroy
	end

end
