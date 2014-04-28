namespace :db do
	desc 'Fill database with sample data' 
	task populate: :environment do
		populate_admin
		populate_members_csv
		populate_jobs
		populate_events
		populate_news
	end	

	def populate_admin
		# Create Bennett
		Member.create!(member_type: 'admin',
					status: 'officer',
					password: 'qwerty2',
					password_confirmation: 'qwerty2',
					image: 'profile.png',
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

	def populate_members_csv
		require 'csv'    

		CSV.foreach("db/kd_alumni_list.csv", headers: true) do |row|
			csv = row.to_hash

			# skip if row is nil, first or last name is empty
			next if csv.nil? || csv['SALUT'].empty? || csv['LASTNAME'].empty?

			member_type 	= 'normal' # super admin, admin, normal
			status 			= 'member' # member, officer, board of directors
			image 			= 'default.png'
			headline 		= ''
			first_name 		= csv['SALUT']
			last_name 		= csv['LASTNAME']
			class_year 		= csv['Class']
			class_prefix 	= csv['Class'] || '9999'
			user_name 		= first_name[0..1] + last_name[0..2] + class_prefix[2..3]
			major 			= ''
			summary 		= ''
			url_resume		= '' 
			address			= csv['ADDRLINE1']
			state 			= csv['STATE']
			city			= csv['CITY_NAME']
			zip 			= csv['ZIP']
			industry		= ''
			email			= csv['EMAIL'] || ''
			phone			= csv['PHONE']
			url_facebook	= ''
			url_twitter		= ''
			url_linkedIn	= ''
			url_personal	= ''

			# Create the member
			member = Member.create!(member_type: member_type,
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
			puts "#{member.id} created"
		end
	end

	def populate_members
		# Create 40 members
		40.times do |n|
			member_type 	= 'normal'
			status 			= 'member' # member, officer, board of directors
			image 			= 'profile.png'
			headline 		= Faker::Lorem.sentences(3).join(' ')
			first_name 		= Faker::Name.first_name
			last_name 		= Faker::Name.last_name
			user_name 		= first_name[0..1] + last_name[0..2] + '14' 
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
		members 	= Member.find([*1..3])

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
		member 	= Member.find(1)

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
		member 	= Member.find(2)

		# Member will create 10 news 
		10.times do |n|
			title 		= "News Title #{n}"
			images		= ['profile.png', 'profile.png', 'profile.png']
			summary 	= Faker::Lorem.paragraphs(5).join("\n\n")
			body 		= Faker::Lorem.paragraphs(10).join("\n\n")
			member.news.create!(title: title, images: images, summary: summary, body: body)
		end
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