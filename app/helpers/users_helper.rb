module UsersHelper

  #assings a gravatar id based on the md5 hash of the users email
  #url is based on users email they signup with
  #will return the default if none is provided
  def gravatar_for(user, size: 100)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end

end
