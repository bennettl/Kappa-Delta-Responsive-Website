class CreateDaggers < ActiveRecord::Migration
  def change
    create_table :daggers do |t|
    	t.string :title
    	t.date :dagger_date # date dagger article was written
		t.string :author
		t.attachment :pdf
    	t.timestamps
    end
  end
end
