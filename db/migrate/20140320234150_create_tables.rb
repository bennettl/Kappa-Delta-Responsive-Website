class CreateTables < ActiveRecord::Migration
  def change
  	# Members
    create_table :members do |t|
		# hidden info
		t.string :member_type # super admin, admin, normal
		t.string :status # bod, officer, member
		t.string :password_digest
		# basic infor
		t.string :image #profile image
		t.string :headline
		t.string :first_name
		t.string :last_name
		t.string :user_name # first initial, last name (first 3 characters), 2 digit grad year 
		t.integer :class_year
		t.string :major
		t.text :summary
		t.string :url_resume
		# contact
		t.string :location
		t.string :address
		t.string :industry
		t.string :email
		t.string :phone
		# socail network urls
		t.string :url_facebook
		t.string :url_twitter
		t.string :url_linkedIn
		t.string :url_personal
		t.timestamps
    end

    # Jobs
    create_table :jobs do |t|
		t.belongs_to :member # member who created job
		t.boolean :hidden # viewable or not
		t.string :title
		t.string :company
		t.string :job_type # Internship/ Part Time/Full Time /Temporary
		t.string :location # predefine list
		t.date :start_date
		t.date :deadline
		t.string :industry #predefine list
		t.text :description
		t.text :qualification
		t.text :compensation
		t.text :how_to_apply
		t.timestamps
    end

    # Events
    create_table :events do |t|
    	t.belongs_to :member # member who created the event
    	t.string :title
		t.string :location
		t.datetime :start_time
		t.datetime :end_time
		t.text :description
    	t.timestamps
    end

    # News
    create_table :news do |t|
    	t.belongs_to :member # member who created the news
    	t.string :title
		t.string :images
		t.text :summary
		t.text :body

    	t.timestamps
    end

    # create_table :liked_jobs do |t|
    # 	t.belongs_to :job
    # 	t.belongs_to :member
    # end
  end
end
