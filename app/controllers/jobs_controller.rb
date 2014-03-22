class JobsController < ApplicationController
	
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
			redirect_to jobs_path
		else
			render 'new'
		end
	end

	# Display form for updating an existing job
	def edit
	end

	# Update an existing job
	def update
	end

	# Show individual job
	def show
		@job = Job.find(params[:id])
	end

	# Destroy a job
	def destroy
	end

	private

	# Strong parameters
	def job_params
		params.require(:job).permit(:hidden, :title, :company, :job_type, :location, :start_date, :deadline, :industry, :description, :qualification, :compensation, :how_to_apply)
	end
end
