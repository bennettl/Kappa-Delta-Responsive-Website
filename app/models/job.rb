class Job < ActiveRecord::Base
	# WYSIWYG editor
	# include Bootsy::Container

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

	def self.search(search)
		if search
			# Parameters
			query 	= []
			like 	= Rails.env.development? ? 'LIKE' : 'ILIKE' ; #case insensitive for postgres

			query.push((search[:job_type].blank?) ? '' : "job_type #{like} '%#{search[:job_type]}%'")
			query.push((search[:location].blank?) ? '' : "location #{like} '%#{search[:location]}%'")
			query.push((search[:industry].blank?) ? '' : "industry #{like} '%#{search[:industry]}%'")
			
			# If deadline is not blank
			if !search[:deadline].blank?
				deadline = search[:deadline]
				#deadline 	=  Date.strptime(search[:deadline], "%d/%m/%Y")
				query.push("deadline < '#{deadline}'")
			end

			query.reject! {|q| q.empty? }

			# Search for all fields
			self.where(query.join(' AND '))
		else
			# all users
			scoped
		end
	end
end
