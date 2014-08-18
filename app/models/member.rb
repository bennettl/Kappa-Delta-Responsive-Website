class Member < ActiveRecord::Base
	# commented out because memberes from excel file are not guarantee to have email
	# before_save { self.email = email.downcase }
	before_save { self.user_name = user_name.downcase }
	before_create :create_remember_token

	# Association
	has_many :jobs_created, class_name: 'Job', dependent: :destroy
	has_many :events, dependent: :destroy
	has_many :news, dependent: :destroy
	has_many :donations, dependent: :destroy

	# Attachments (avatar/resume)
	has_attached_file :avatar, 
						:styles => { :medium => "200x200>", :thumb => "100x100>" }, 
						:default_url => "/images/member/:style/profile.png", 
						:url => ":s3_domain_url",
						:path => ":rails_root/public/assets/members/avatar/:id/:style/:basename.:extension",
	                    :s3_protocol => :https
	validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

	has_attached_file :resume,
						:url => ":s3_domain_url",
	                    :path => ":rails_root/public/assets/members/resume/:id/:style/:basename.:extension"
 	validates_attachment_content_type :resume, :content_type => ['application/pdf', 'application/msword', 'text/plain'], :if => :resume_attached?

	# Validation
	validates :member_type, presence: true, inclusion: ['super admin', 'admin', 'normal']
	validates :status, presence: true, inclusion: ['bod', 'officer', 'member']
	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :user_name,  presence: true, uniqueness: true
	
	# VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	# validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
	# validates :password, length: { minimum: 5 }

	# Handles password 
	has_secure_password

	# Create a random string 
	def self.new_remember_token
	    SecureRandom.urlsafe_base64
	end

	# Encrpty a string with SHA1
	def self.encrypt(token)
	    Digest::SHA1.hexdigest(token.to_s)
	end

	# Searches members base similar (LIKE) to search hash
	def self.search(search)
		if search
			# Parameters
			query 		= []
			like 		= Rails.env.development? ? 'LIKE' : 'ILIKE' ; #case insensitive for postgres
			class_year 	= Rails.env.development? ? 'class_year' : 'CAST(class_year AS TEXT)'; # postgres LIKE for integer

			query.push((search[:first_name].blank?) ? '' : "first_name #{like} '%#{search[:first_name]}%'")
			query.push((search[:last_name].blank?) ? '' : "last_name #{like} '%#{search[:last_name]}%'")
			query.push((search[:major].blank?) ? '' : "major #{like} '%#{search[:major]}%'")
			query.push((search[:city].blank?) ? '' : "city #{like} '%#{search[:city]}%'")
			query.push((search[:class_year].blank?) ? '' : "#{class_year} #{like} '%#{search[:class_year]}%'")
			query.push((search[:industry].blank?) ? '' : "industry #{like} '%#{search[:industry]}%'")

			query.reject! {|q| q.empty? }

			# Search for all fields
			self.where(query.join(' AND '))
		else
			# all users
			scoped
		end
	end

	# Handles importing an excel file and updating the members database with it
	def self.import(file)
		spreadsheet = open_spreadsheet(file)
		header = spreadsheet.row(1)
		
		updated = [] # members that were updated
		created = [] # members that were created

		# Go throuh every row of spreadsheet
		(2..spreadsheet.last_row).each do |i|
			# Convert the array of values with header as the key and transform it into a hash
		    row 			= Hash[[header, spreadsheet.row(i)].transpose]
			user_name 		= row['User ID']
			first_name 		= row['First Name']
			last_name 		= row['Last Name']
			class_year 		= row['Class Year']
			major 			= row['Major']
			phone 			= row['Phone']
			email			= row['Email']
			address			= row['Address']
			city			= row['City']
			state 			= row['State']
			zip 			= row['Zip']
			country 		= row['Country']

			member 			= Member.find_by({user_name: user_name})

			# If member exist
			if !member.nil?
				# Update attributes of existing member
				attributes 		= { user_name: user_name, first_name: first_name, last_name: last_name, class_year: class_year, major: major, 
								phone: phone, email: email, address: address, city: city, state: state, zip: zip, country: country }
				member.update_attributes(attributes)
				updated.push(member.name)
			else
				# Otherwise, create a new member
				member = Member.create!(member_type: 'normal',
										status: 'member',
										password: 'qwerty',
										password_confirmation: 'qwerty',
										first_name: first_name,
										last_name: last_name,
										user_name: user_name,
										class_year: class_year,
										major: major,
										email: email,
										phone: phone,
										address: address,
										state: state,
										city: city,
										zip: zip,
										country: country,
										headline: '',
										summary: '',
										url_resume: '',
										industry: '',
										url_facebook: '',
										url_twitter: '',
										url_linkedIn: '',
										url_personal: '')
				created.push(member.name)
			end
		end

		# Return the information on members that were updated/created
		members_info = {updated: updated, created: created}
	end

	# Opens a spreadsheet file, helper function for self.import
	def self.open_spreadsheet(file)
		case File.extname(file.original_filename)
			when ".csv" then Roo::Csv.new(file.path, nil, :ignore)
			when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
			when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
			else raise "Unknown file type: #{file.original_filename}"
		end
	end
	# Returns full name
	def name
		"#{first_name} #{last_name}"
	end

	# Forem
	def forem_name
		name
	end
	def forem_email
		email
	end

	def resume_attached?
		self.resume.file?
	end

	private

	# Create a new remember token (encrptyed string)
	def create_remember_token
		self.remember_token = Member.encrypt(Member.new_remember_token)
	end
end
