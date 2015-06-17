require 'faker'

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

 user = User.first
 # user.skip_reconfirmation!
 user.update_attributes!(
   name: 'user1',
   email: 'user1@example.com',
   password: 'foobar',
   admin: true,
   activated: true,
   activated_at: Time.zone.now
 )

 puts "Seed finished"
 puts "#{User.count} users created"