# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Role.create(:name => "admin")
Role.create(:name => "user")
User.create(:email => "admin@foo.bar", :password => "123456")
User.create(:email => "user@foo.bar",  :password => "123456")
User.create(:email => "user1@foo.bar", :password => "123456")
User.find_by_email("admin@foo.bar").roles << Role.find_by_name("admin")
User.find_by_email("user@foo.bar").roles << Role.find_by_name("user")
User.find_by_email("user1@foo.bar").roles << Role.find_by_name("user")