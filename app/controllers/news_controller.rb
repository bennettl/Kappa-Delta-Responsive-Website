class NewsController < ApplicationController
	
	# Display list of all news
	def index
		@news = News.all
	end

	# Display an individual news
	def show
		@news = News.find(params[:id])
	end

	# Display form to create a new news
	def new
		@news = News.new
	end

	# Create a new news
	def create

	end

	# Display form to update an existing news
	def edit
		@news = News.find(params[:id])
	end 

	# Update an existing news
	def update

	end

	# Remove an existing news
	def destroy

	end

end
