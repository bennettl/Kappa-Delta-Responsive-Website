class MembersController < ApplicationController

	# List all members
	def index
		# Default values for params hash
		params[:sort] ||= 'first_name'
		params[:direction] ||= 'asc'
		
		@members = Member.search(member_params_search).order(params[:sort] + ' ' + params[:direction]).paginate(per_page: 10, page: params[:page])
		#@members = Member.all.paginate(per_page: 5, page: params[:page])
	end

	# Show individual member
	def show
		@member = Member.find(params[:id])
	end

	# Display form to create a new member
	def new
		@member = Member.new
	end

	# Create a new member
	def create
		@member = Member.new(member_params)
		if @member.save
			flash[:success] = "User Sucessfully Created"
			redirect_to new_member_path
		else
			render 'new'
		end
	end

	# Display form for updating an existing member
	def edit
		@member = Member.find(params[:id])
	end

	# Update an existing member
	def update
		@member = Member.find(params[:id])
		
		# If update is sucessful, redirect to member page, else render edit page
		if @member.update_attributes(member_params_update)
			flash[:success] = "Update is sucessful"
			redirect_to @member
		else

			render 'edit'
		end
	end

	# Destroy an existing member
	def destroy
		Member.delete(params[:id])
		flash[:success] = 'User Sucessfully Destroyed'
		redirect_to members_path
	end

	# Autocompletion
	def autocomplete
		# Default values
		column 	= params[:column] || 'major'
		value 	= params[:value] || '5'
		# Select unique column values base on value variable
		users 	= Member.select(column).where("#{column} LIKE '%#{value}%'").uniq
		# Only get the column value (not the id) in the users set
		result 	= users.collect do |u|
			    	u[column].to_s
			    end
		# Return a JSON formatted data
		render json: result
	end

	
	def import_form
	end

	# Handles importing an excel file and updating the members database with it
	def import
		members_info = Member.import(params[:file])
		flash[:success] = "Brother's Database Sucessfully Updated!" 
		redirect_to members_path(members_info: members_info)
	end

	private

		# Strong parameters

		# If password is blank, don't include it
		def member_params_update
			if params[:member][:password].blank?
				params.require(:member).permit(:member_type, :headline, :status, :email, :user_name, :first_name, :last_name, :major, :address, :phone, :city, :state, :zip, :country, :class_year, :industry, :avatar, :summary,  :resume, :url_facebook, :url_twitter, :url_linkedIn, :url_personal)
			else
				member_params
			end
		end		

		def member_params
			params.require(:member).permit(:member_type, :status, :email, :user_name, :first_name, :last_name, :major, :city, :zip, :country, :class_year, :industry, :password, :password_confirmation, :avatar, :resume)
		end

		def member_params_search
			params.permit(:first_name, :last_name, :city, :industry, :major, :class_year, :password, :password_confirmation)
		end
end
