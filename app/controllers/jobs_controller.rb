class JobsController < ApplicationController
	
	# List all jobs
	def index
		@jobs = Job.all
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

		# If update is sucessful, redirect to job page, else render edit page
		if @job.update_attributes(job_params)
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

	private

	# Strong parameters
	def job_params
		params.require(:job).permit(:hidden, :title, :company, :job_type, :location, :start_date, :deadline, :industry, :description, :qualification, :compensation, :how_to_apply)
	end
end
