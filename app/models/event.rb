class Event < ActiveRecord::Base
	# Serialization
	serialize :description, JSON

	# Validation
	validates :title, presence: true
	validates :location, presence: true
	validates :start_time, presence: true
	validates :end_time, presence: true
	validates :description, presence: true
end
