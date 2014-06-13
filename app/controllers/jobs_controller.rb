class JobsController < ApplicationController
	
	# List all jobs
	def index
		# Default values for params hash
		params[:sort] ||= 'deadline'
		params[:direction] ||= 'asc'
		@jobs = Job.search(job_params_search).order(params[:sort] + ' ' + params[:direction]).paginate(per_page: 8, page: params[:page])
		# @jobs = Job.all.paginate(per_page: 5, page: params[:page])
	end

	# Display form for creating a new job
	def new
		current_member = Member.first # needs to be replace with current member
		@job = current_member.jobs_created.new
	end

	# Creating a new job
	def create
		current_member = Member.first # needs to be replace with current member
		@job = current_member.jobs_created.new(job_params)
		if @job.save
			redirect_to @job
		else
			render 'new'
		end
	end

	# Display form for updating an existing job
	def edit
		@job = Job.find(params[:id])
	end

	# Update an existing job
	def update
		@job = Job.find(params[:id])
		@job_params = job_params

		# job_params_formatted_date contains the formatted start_time/end_time appropriate for update_attributes
		job_params_formatted_date = job_params
		job_params_formatted_date[:start_date] = DateTime.parse(job_params[:start_date] + "1:00 AM")
		job_params_formatted_date[:deadline] = DateTime.parse(job_params[:deadline] + "1:00 AM")

		# If update is sucessful, redirect to job page, else render edit page
		if @job.update_attributes(job_params_formatted_date)
			flash[:success] = "Job Sucessfully Updated"
			redirect_to @job
		else
			render 'edit'
		end
	end

	# Show individual job
	def show
		@job = Job.find(params[:id])
	end

	# Destroy a job
	def destroy
		Job.delete(params[:id])
		flash[:success] = "Job Sucessfully Destroy"
		redirect_to jobs_path
	end

	# Autocompletion
	def autocomplete
		# Default values
		column 	= params[:column] || ''
		value 	= params[:value] || ''

		# Select unique column values base on value variable
		jobs 	= Job.select(column).where("#{column} LIKE '%#{value}%'").uniq
		# Only get the column value (not the id) in the jobs set
		result 	= jobs.collect do |u|
			    	u[column].to_s
			    end
		# Return a JSON formatted data
		render json: result
	end

	private

	# Strong parameters
	def job_params
		params.require(:job).permit(:hidden, :title, :company, :job_type, :location, :start_date, :deadline, :industry, :description, :qualification, :compensation, :how_to_apply)
	end

	# Without the require
	def job_params_search
		params.permit(:job_type, :location, :deadline, :industry)
	end
end
