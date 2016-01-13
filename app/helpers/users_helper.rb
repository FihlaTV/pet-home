module UsersHelper
  def gravatar_for(user, options = { size: 164 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    if user.image
      gravatar_url = user.image
    else
      gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    end
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
end
