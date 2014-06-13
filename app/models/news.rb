class News < ActiveRecord::Base
	# Serialize images
	serialize :images, JSON

	# Association
	belongs_to :member
	
	# Attachment 
	has_attached_file :image,
						:styles => { :medium => "500x500>", :thumb => "150x150>" }, 
						:url => "/assets/news/:id/:style/:basename.:extension",
						:path => ":rails_root/public/assets/news/:id/:style/:basename.:extension"
	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

	# Validation
	validates :title, presence: true
	validates :summary, presence: true
	validates :body, presence: true

end
