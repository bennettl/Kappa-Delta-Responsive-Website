 namespace :db do
	desc 'Fill database with sample data' 
	task do_sql: :environment do
		some_sql
	end	
	def some_sql
		sql = "INSERT INTO 'forem_forums' ('title', 'description') VALUES ('Cardinal','Tom B. Erichsen')"
		ActiveRecord::Base.connection.execute(sql)
	end
end

