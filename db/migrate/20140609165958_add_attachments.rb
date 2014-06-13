class AddAttachments < ActiveRecord::Migration
	def self.up
		change_table :members do |t|
			t.attachment :avatar
			t.attachment :resume
		end
		change_table :news do |t|
			t.attachment :image
		end
	end

	def self.down
		drop_attached_file :members, :avatar
		drop_attached_file :members, :resume
		drop_attached_file :news, :image
	end
end
