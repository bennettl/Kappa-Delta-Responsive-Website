class CreateDonations < ActiveRecord::Migration
  def change
  	# Donations
    create_table :donations do |t|
		t.string :email
		t.string :first_name
		t.string :last_name
		t.integer :amount
		t.boolean :visible
		t.timestamps
	 	# add_index :email
    end
  end
end
