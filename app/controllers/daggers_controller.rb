class DaggersController < ApplicationController

	# Displays list of all daggers
	def index
		@daggers = Dagger.order('dagger_date DESC').paginate(per_page: 8, page: params[:page])
	end

	# Display an existing dagger
	def show
		@dagger = Dagger.find(params[:id])
	end

	# Display form to create a new dagger
	def new
		@dagger = Dagger.new
	end

	# Creates a new dagger article
	def create
		@dagger = Dagger.new(dagger_params)

		# If save is successfully, redirect to dagger page, else re-render new page
		if @dagger.save
			flash[:success] = "Dagger Sucesssfully Created!"
			redirect_to @dagger
		else
			render 'new'
		end
	end

	# Displays a form to update an existing dagger
	def edit
		@dagger = Dagger.find(params[:id])
	end

	# Updates an existing dagger
	def update
		@dagger = Dagger.find(params[:id])

		if @dagger.update_attributes(dagger_params)
			flash[:success] = "Dagger Sucessfully Updated"
			redirect_to @dagger
		else
			render 'edit2'
		end
	end

	# Removes an existing dagger
	def destroy
		Dagger.delete(params[:id])
		flash[:success] = "Dagger Sucesssfully Removed!"
		redirect_to daggers_path
	end
	
	private

	# Strong parameters
	def dagger_params
		params.require(:dagger).permit(:title, :dagger_date, :author, :pdf)
	end
end
