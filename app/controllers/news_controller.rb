class NewsController < ApplicationController
	
	# Display list of all news
	def index
		@news = News.order("created_at DESC").paginate(per_page: 5, page: params[:page])
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
		@news = current_member.news.build(news_params)

		if @news.save
			flash[:success] = "News successfully created"
			redirect_to news_path(@news)
		else
			render 'show'
		end
	end

	# Display form to update an existing news
	def edit
		@news = News.find(params[:id])
	end 

	# Update an existing news
	def update
		@news = News.find(params[:id])

		# If update is sucessful, redirect to news page, else, render the edit page
		if @news.update_attributes(news_params)
			flash[:success] = "News successfully updated"
			redirect_to @news
		else
			render 'edit'
		end

	end

	# Remove an existing news
	def destroy
		News.delete(params[:id])
		flash[:success] = "News successfully removed"
		redirect_to news_index_path
	end

	private

		# Strong paramters
		def news_params
			params.require(:news).permit(:title, :image, :summary, :body, :bootsy_image_gallery_id)
		end

end
