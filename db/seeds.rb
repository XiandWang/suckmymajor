# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(name: "xiandong", 
			email: "xiw@seas.upenn.edu",
			password:                 "iverson",
			password_confirmation:    "iverson",
			admin: true,
			activated: true,
			activated_at: Time.zone.now)

99.times do |n|
	name = Faker::Name.name
	email = "example-#{n+1}@railstutorial.org"
	password = "password"
	User.create!(name: name,
				email: email,
				password: password,
				password_confirmation: password)
end

Major.create!(name: "Computer Science")
Major.create!(name: "Psychology")

users = User.all
half_users = users[0...50]
other_users = users[50...100]

cs = Major.first
psyc = Major.second

half_users.each {|user| user.join(cs)}
other_users.each {|user| user.join(psyc) }



