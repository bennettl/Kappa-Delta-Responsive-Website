class Member < ActiveRecord::Base
	before_save { self.email = email.downcase }
	before_create :create_remember_token

	# Association
	has_many :jobs_created, class_name: 'Job', dependent: :destroy
	has_many :events, dependent: :destroy
	has_many :news, dependent: :destroy

	# Validation
	validates :member_type, presence: true, inclusion: ['super admin', 'admin', 'normal']
	validates :status, presence: true, inclusion: ['bod', 'officer', 'member']
	validates :first_name, presence: true
	validates :last_name, presence: true
	# validates :address, presence: true
	# validates :class_year, presence: true
	# validates :major, presence: true
	# validates :industry, presence: true
	validates :user_name,  presence: true, uniqueness: true
	
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	# validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
	validates :password, length: { minimum: 5 }

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
			query 	= []
			query.push((search[:first_name].blank?) ? '' : "first_name LIKE '%#{search[:first_name]}%'")
			query.push((search[:last_name].blank?) ? '' : "last_name LIKE '%#{search[:last_name]}%'")
			query.push((search[:major].blank?) ? '' : "major LIKE '%#{search[:major]}%'")
			query.push((search[:city].blank?) ? '' : "city LIKE '%#{search[:city]}%'")
			query.push((search[:class_year].blank?) ? '' : "class_year LIKE '%#{search[:class_year]}%'")
			query.push((search[:industry].blank?) ? '' : "industry LIKE '%#{search[:industry]}%'")

			query.reject! {|q| q.empty? }

			# Search for all fields
			self.where(query.join(' AND '))
		else
			# all users
			scoped
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

	private

	# Create a new remember token (encrptyed string)
	def create_remember_token
		self.remember_token = Member.encrypt(Member.new_remember_token)
	end
end
