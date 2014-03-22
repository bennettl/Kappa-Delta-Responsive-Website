class News < ActiveRecord::Base
	# Serialize images
	serialize :images, JSON
	serialize :summary, JSON
	serialize :body, JSON
	
	# Validates
	validates :title, presence: true
	validates :images, presence: true
	validates :summary, presence: true
	validates :body, presence: true

end
