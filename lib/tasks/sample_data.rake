namespace :db do
	desc 'Fill database with sample data' 
	task populate: :environment do
		populate_admin
		populate_members_csv
		# populate_jobs
		populate_events
		populate_news
		populate_forums
	end	

	def populate_admin
		# Create Bennett
		Member.create!(member_type: 'admin',
					status: 'officer',
					password: 'thekds',
					password_confirmation: 'thekds',
					headline: Faker::Lorem.sentences(1).join("\n\n"),
					first_name: 'Bennett',
					last_name: 'Lee',
					user_name: 'blee14',
					class_year: '2014',
					major: 'Business',
					summary: Faker::Lorem.paragraphs(5).join("\n\n"),
					url_resume: 'http://www.facebook.com',
					address: 'Los Angeles',
					state: 'State',
					city: 'My City',
					zip: '90007',
					industry: 'Software',
					email: 'bennettl908@yahoo.com',
					phone: '800-123-4567',
					forem_admin: true,
					url_facebook: "http://www.facebook.com/",
					url_twitter: "http://www.twitter.com/",
					url_linkedIn: "http://www.linkedin.com/",
					url_personal: "http://www.personal.com/")

	end

	# Populate members through alumni list csv file
	def populate_members_csv
		require 'csv'    

		CSV.foreach("db/kd_alumni_list.csv", headers: true) do |row|
			csv = row.to_hash

			# skip if row is nil, first or last name is empty
			next if csv.nil? || csv['First Name'].empty? || csv['Last Name'].empty?

			member_type 	= csv['Admin'] == 'TRUE' ? 'admin' : 'normal' # super admin, admin, normal
			status 			= 'member' # member, officer, board of directors
			forem_admin		= csv['Admin'] == 'TRUE' ? true : false
			headline 		= ''
			first_name 		= csv['First Name']
			last_name 		= csv['Last Name']
			class_year 		= csv['Class Year']
			user_name		= csv['User ID'] # first_name[0...1] + last_name[0...3] + class_prefix[2..3]
			major 			= csv['Major']
			summary 		= ''
			url_resume		= ''
			address			= csv['Address']
			state 			= csv['State']
			city			= csv['City']
			zip 			= csv['Zip']
			country 		= "United States" 
			industry		= ''
			email			= csv['Email'] || ''
			phone			= csv['Phone']
			url_facebook	= ''
			url_twitter		= ''
			url_linkedIn	= ''
			url_personal	= ''

			# Find or intialize member
			member = Member.find_or_initialize_by(user_name: user_name)
			# Update member attributes
			member.update_attributes(member_type: member_type,
						status: status,
						forem_admin: forem_admin,
						password: 'thekds',
						password_confirmation: 'thekds',
						headline: headline,
						first_name: first_name,
						last_name: last_name,
						user_name: user_name,
						class_year: class_year,
						major: major,
						summary: summary,
						url_resume: url_resume,
						address: address,
						state: state,
						city: city,
						zip: zip,
						country: country,
						industry: industry,
						email: email,
						phone: phone,
						url_facebook: url_facebook,
						url_twitter: url_twitter,
						url_linkedIn: url_linkedIn,
						url_personal: url_personal)
		end
	end

	def populate_members
		# Create 40 members
		40.times do |n|
			member_type 	= 'normal'
			status 			= 'member' # member, officer, board of directors
			headline 		= Faker::Lorem.sentences(3).join(' ')
			first_name 		= Faker::Name.first_name
			last_name 		= Faker::Name.last_name
			user_name 		= first_name[0...1] + last_name[0...3] + '14' 
			class_year 		= '201' + Faker::Number.digit
			major 			= random_major
			summary 		= Faker::Lorem.paragraphs(5).join(' ')
			url_resume		= "http:www.myresume.com/#{user_name}" 
			address			=  Faker::Address.street_address
			state 			= 'CA'
			city			=  Faker::Address.city
			zip 			= '90007'
			industry		= random_industry
			email			=  Faker::Internet.email
			phone			= '(415)-812-8901'
			url_facebook	= "http://www.facebook.com/#{user_name}"
			url_twitter		= "http://www.twitter.com/#{user_name}"
			url_linkedIn	= "http://www.linkedin.com/#{user_name}"
			url_personal	= "http://www.personal.com/#{user_name}"
			
			# Create the member
			Member.create!(member_type: member_type,
						status: status,
						password: 'qwerty2',
						password_confirmation: 'qwerty2',
						image: image,
						headline: headline,
						first_name: first_name,
						last_name: last_name,
						user_name: user_name,
						class_year: class_year,
						major: major,
						summary: summary,
						url_resume: url_resume,
						address: address,
						state: state,
						city: city,
						zip: zip,
						industry: industry,
						email: email,
						phone: phone,
						url_facebook: url_facebook,
						url_twitter: url_twitter,
						url_linkedIn: url_linkedIn,
						url_personal: url_personal)
		end
	end

	def populate_jobs
		members 	= Member.limit(4)

		# Create 20 differnt types of jobs
		20.times do |n|
			hidden 			= false
			title 			= "Job Title #{n}"
			company 		= "Company #{n}"
			job_type 		= random_job_type
			location 		= Faker::Address.city
			industry 		= random_industry
			start_date 		= random_date
			deadline 		= start_date + 10
			description 	= Faker::Lorem.paragraphs(5).join("\n\n")
			qualification 	= Faker::Lorem.paragraphs(3).join("\n\n")
			compensation 	= Faker::Lorem.sentences(3).join("\n\n")
			how_to_apply 	= Faker::Lorem.paragraphs(2).join("\n\n")

			# Each member will create that job
			members.each do |member|
				member.jobs_created.create!(hidden: hidden,
								title: title,
								company: company,
								job_type: job_type, 
								location: location,
								start_date: start_date,
								deadline: deadline,
								industry: industry,
								description: description,
								qualification: qualification,
								compensation: compensation,
								how_to_apply: how_to_apply)
			end
		end
	end

	def populate_events
		member 	= Member.first

		# Member will create 10 events 
		10.times do |n|
			title 			= "Event Title #{n}"
			location 		= Faker::Address.city
			start_time 		= random_date
			end_time  		= random_date + 10
			description 	= Faker::Lorem.paragraphs(5).join("\n\n")
			member.events.create!(title: title, location: location, start_time: start_time, end_time: end_time, description: description)
		end
	end

	def populate_news
		member 	= Member.first

		# Member will create 10 news 
		10.times do |n|
			title 		= "News Title #{n}"
			images		= ['profile.png', 'profile.png', 'profile.png']
			summary 	= Faker::Lorem.paragraphs(5).join("\n\n")
			body 		= Faker::Lorem.paragraphs(10).join("\n\n")
			member.news.create!(title: title, images: images, summary: summary, body: body)
		end
	end

	def populate_forums
		cat_gen = Forem::Category.create!(name: "General")
		cat_gen.forums.create!(name: "Pub", description: "This is the main forum area. If you're not sure where to post, start here.")
		cat_gen.forums.create!(name: "On Campus", description: "For all discussions regarding actives and on campus happenings.")
		cat_gen.forums.create!(name: "Professional", description: "For all discussions related to careers, business, jobs, and internships.")

		cat_geo = Forem::Category.create!(name: "Geographical")
		cat_geo.forums.create!(name: "Los Angeles", description: "Discussions related to the greater Los Angeles area.")
		cat_geo.forums.create!(name: "San Francisco", description: "Discussions related to the greater Bay Area.")
		cat_geo.forums.create!(name: "New York", description: "Discussions related to the greater New York City area.")
		cat_geo.forums.create!(name: "San Diego", description: "Discussions related to the greater San Diego area.")
		cat_geo.forums.create!(name: "Seattle", description: "Discussions related to the greater Seattle area.")
		cat_geo.forums.create!(name: "Chicago", description: "Discussions related to the greater Chicago area.")
		cat_geo.forums.create!(name: "Washington DC", description: "Discussions related to the greater DC area.")
		cat_geo.forums.create!(name: "Boston", description: "Discussions related to the greater Boston area.")
		cat_geo.forums.create!(name: "Everywhere Else", description: "geographically-anchored discussions for the rest of the world.")

		cat_dec = Forem::Category.create!(name: "By Decade")
		cat_dec.forums.create!(name: "2010s", description: "Discussions specific to the 2010s classes.")
		cat_dec.forums.create!(name: "2000s", description: "Discussions specific to the 2000s classes.")
		cat_dec.forums.create!(name: "1990s", description: "Discussions specific to the 1990s classes.")
		cat_dec.forums.create!(name: "1980s", description: "Discussions specific to the 1980s classes.")
		cat_dec.forums.create!(name: "1970s", description: "Discussions specific to the 1970s classes.")
		cat_dec.forums.create!(name: "1960s", description: "Discussions specific to the 1960s classes.")
		cat_dec.forums.create!(name: "1950s", description: "Discussions specific to the 1950s classes.")
	end

	def random_date
		[*1..30].sample.days.from_now.to_date
	end
	def random_job_type
		['Internship', 'Part Time', 'Full Time', 'Temporary'].sample
	end

	def random_major
		['major1', 'major2','major3', 'major4', 'major5'].sample
	end

	def random_industry
		['industry1', 'industry2','industry3', 'industry4', 'industry5'].sample
	end
end