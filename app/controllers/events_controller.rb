class EventsController < ApplicationController
	
	# Display list of all events
	def index
		@events = Event.order('start_time ASC').paginate(per_page: 6, page: params[:page])
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
		@event = current_member.events.build(event_params)

		# If save is successful, redirect to event page, else re-render new page
		if @event.save
			flash[:success] = "Event successfully created"
			redirect_to @event
		else
			render 'new'
		end
	end

	# Display form to update an existing event
	def edit
		@event = Event.find(params[:id])
	end 

	# Update an existing event
	def update
		@event = Event.find(params[:id])

		# event_params_formatted_date contains the formatted start_time/end_time appropriate for update_attributes
		event_params_formatted_date = event_params
		event_params_formatted_date[:start_time] = DateTime.parse(event_params[:start_time])
		event_params_formatted_date[:end_time] = DateTime.parse(event_params[:end_time])

		# If update is successful, redirect to event page, else re-render edit page
		if @event.update_attributes(event_params_formatted_date)
			flash[:success] = "Event successfully updated"
			redirect_to @event
		else
			render 'edit'
		end
	
	end

	# Remove an existing event
	def destroy
		Event.delete(params[:id])
		flash[:success] = "Event successfully destroy"
		redirect_to events_path
	end

	private

	# Strong parameters
	def event_params
		params.require(:event).permit(:title, :location, :start_time, :end_time, :description)
	end


end
