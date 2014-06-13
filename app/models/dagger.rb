class Dagger < ActiveRecord::Base
	
	# Attachement 
	has_attached_file :pdf,
	                    :url  => "/assets/daggers/:id/:style/:basename.:extension",
	                    :path => ":rails_root/public/assets/daggers/:id/:style/:basename.:extension"
 	validates_attachment_content_type :pdf, :content_type => ['application/pdf', 'application/msword', 'text/plain'], :if => :pdf_attached?

 	# Validation
	validates :title, presence: true
	validates :dagger_date, presence: true
	validates :author, presence: true
	validates :pdf, presence: true

	def pdf_attached?
		self.pdf.file?
	end
end
