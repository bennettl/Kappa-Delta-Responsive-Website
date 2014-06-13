class Member < ActiveRecord::Base
	before_save { self.email = email.downcase }
	before_create :create_remember_token

	# Association
	has_many :jobs_created, class_name: 'Job', dependent: :destroy
	has_many :events, dependent: :destroy
	has_many :news, dependent: :destroy

	# Attachments (avatar/resume)
	has_attached_file :avatar, 
						:styles => { :medium => "200x200>", :thumb => "100x100>" }, 
						:default_url => "/images/member/:style/profile.png", 
						:url => "/assets/members/avatar/:id/:style/:basename.:extension",
						:path => ":rails_root/public/assets/members/avatar/:id/:style/:basename.:extension"
	validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

	has_attached_file :resume,
	                    :url  => "/assets/members/resume/:id/:style/:basename.:extension",
	                    :path => ":rails_root/public/assets/members/resume/:id/:style/:basename.:extension"
 	validates_attachment_content_type :resume, :content_type => ['application/pdf', 'application/msword', 'text/plain'], :if => :resume_attached?

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
			query 	= []
			like 	= Rails.env.development? ? 'LIKE' : 'ILIKE' ; #case insensitive for postgres

			query.push((search[:first_name].blank?) ? '' : "first_name #{like} '%#{search[:first_name]}%'")
			query.push((search[:last_name].blank?) ? '' : "last_name #{like} '%#{search[:last_name]}%'")
			query.push((search[:major].blank?) ? '' : "major #{like} '%#{search[:major]}%'")
			query.push((search[:city].blank?) ? '' : "city #{like} '%#{search[:city]}%'")
			query.push((search[:class_year].blank?) ? '' : "class_year #{like} '%#{search[:class_year]}%'")
			query.push((search[:industry].blank?) ? '' : "industry #{like} '%#{search[:industry]}%'")

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

	def resume_attached?
		self.resume.file?
	end

	private

	# Create a new remember token (encrptyed string)
	def create_remember_token
		self.remember_token = Member.encrypt(Member.new_remember_token)
	end
end
