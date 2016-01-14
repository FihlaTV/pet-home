module UsersHelper
  def gravatar_url(user, options = { size: 164 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    if user.image
      user.image
    else
      "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    end
  end
end
