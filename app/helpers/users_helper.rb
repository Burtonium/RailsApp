module UsersHelper
    
  # Returns the Gravatar for the given user.
  def gravatar_for(user)
    id = Digest::MD5::hexdigest(user.email.downcase)     
    url = "https://secure.gravatar.com/avatar/#{id}"
    image_tag(url, alt: user.name, class: "gravatar")
  end        
end
