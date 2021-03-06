class Donation < ActiveRecord::Base
	# Association
	belongs_to :member
	
	# t.timestamps
	# Validation
	validates :email, presence: true
	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :amount, presence: true
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
end
