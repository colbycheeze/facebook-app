# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.delete_all
Relationship.delete_all
Post.delete_all

User.create!(first_name: "Colby",
             last_name: "CheeZe",
             password:  "password",
             email:     "colby@cheeze.com")

99.times do |n|
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  email = Faker::Internet.email
  password = "password"
  User.create!(first_name: first_name,
               last_name: last_name,
               email:     email,
               password:  password)
end

users = User.order(:created_at).take(10)
50.times do
  post_body = Faker::Lorem.sentence(10)
  users.each { |user| user.posts.create!(body: post_body) }
end

users = User.order(:created_at).take(20)
users.each do |user1|
  users.each do |user2|
    unless user1 == user2
      user1.send_request(user2)
      user2.accept_request(user1)
    end
  end
end


