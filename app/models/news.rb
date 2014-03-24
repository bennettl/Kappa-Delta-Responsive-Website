class News < ActiveRecord::Base
	# Serialize images
	serialize :images, JSON
	
	# Validation
	validates :title, presence: true
	validates :summary, presence: true
	validates :body, presence: true

end
