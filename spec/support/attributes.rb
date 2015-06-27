def post_attributes(options = {})
  {
    title: "New Post",
    body:  "The post body must be really really long to get validate.",
    topic: "Adoption",
    user: authenticated_user
  }.merge(options)
end

def authenticated_user(options = {})
   user_options = {email: "email#{rand}@fake.com", password: 'password'}.merge(options)
   user = User.new(user_options)
   user.activated: true
   user.activated_at: Time.zone.now
   user.save
   user
end