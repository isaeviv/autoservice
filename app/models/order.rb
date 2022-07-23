class Order < ApplicationRecord
  
  # has_many :service
  
  validates_presence_of :client_name
  validates_presence_of :client_phone_number
  
end
