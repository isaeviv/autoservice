class ClientDecorator < ApplicationDecorator
  delegate_all

  def full_name
    if [changes["first_name"], changes["second_name"], changes["patronymic"]].any? || full_name_cache.nil?
      [second_name, first_name, patronymic].join(" ")
    else
      full_name_cache
    end
  end

end
