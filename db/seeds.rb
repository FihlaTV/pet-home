require 'faker'

Category.create!([
  {
    name: "Pet Sitters",
    description: "Find available pet sitters nearby."
  },
  {
    name: "Sitters Wanted",
    description: "Require pet sitters."
  },
  {
    name: "Adoption",
    description: "Adoption posts go here."
  },
  {
    name: "Other",
    description: "Posts belong to other categories."
  }
])
categories = Category.all

# Create Users

99.times do
user = User.new(
 name:     Faker::Name.name,
 email:    Faker::Internet.email,
 password: Faker::Lorem.characters(10),
 activated: true,
 activated_at: Time.zone.now
)
user.save!
end
users = User.all

admin = User.create!(
name: 'user1',
email: 'user1@example.com',
password: 'foobar',
admin: true,
activated: true,
activated_at: Time.zone.now
)

member = User.create!(
name: 'Member User',
email: 'member@example.com',
password: 'foobar',
activated: true,
activated_at: Time.zone.now
)

200.times do
Post.create!(
 user:   users.sample,
 category:  categories.sample,
 title:  Faker::Lorem.sentence,
 body:   Faker::Lorem.paragraph
)
end

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Post.count} posts created"