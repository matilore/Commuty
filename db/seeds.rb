# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts 'launching seeds'


Request.destroy_all
Revision.destroy_all
Post.destroy_all
Category.destroy_all

puts 'Posts, Requests and Revisions destroyed'

puts 'populating seeds'

User.all.each do |user|
	2.times do |i|
		user.posts.create(title: Faker::Lorem.word, content: Faker::Lorem.paragraph)
	end
end

Post.all.each do |post|
	5.times do |i|
	post.categories.create(name: Faker::Commerce.department(1))
	end
end