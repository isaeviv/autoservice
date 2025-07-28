module UsersHelper
  def show_attribute(user, attribute)
    return local_time(user.public_send(attribute), format: "%d %b %Y, %H:%M") if attribute == :created_at
    user.public_send attribute
  end

  # types defined in UserPhotoUploader
  def avatar_for(user, type: :thumb)
    return image_tag(user.photo.url(type)) if user.photo.present?
    inline_svg_tag("default_avatar", class: "default_avatar_#{type}")
  end
end
