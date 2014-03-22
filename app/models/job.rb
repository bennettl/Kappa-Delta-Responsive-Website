class Job < ActiveRecord::Base
	# Association
	belongs_to :member

	# Validation
	validates :hidden, inclusion:[true, false]
	validates :member_id, presence: true
	validates :title, presence: true
	validates :company, presence: true
	validates :industry, presence: true
	validates :location, presence: true
	validates :job_type, presence: true, inclusion:['Internship', 'Part Time', 'Full Time', 'Temporary']
	validates :start_date, presence: true
	validates :deadline, presence: true
	validates :description, presence: true
	validates :qualification, presence: true
	validates :compensation, presence: true
	validates :how_to_apply, presence: true

end
