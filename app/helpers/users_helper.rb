module UsersHelper
  def show_attribute(user, attribute)
    return local_time(user.public_send(attribute), format: "%d %b %Y, %H:%M") if attribute == :created_at

    user.public_send attribute
  end
end
