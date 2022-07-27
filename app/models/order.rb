class Order < ApplicationRecord
  
  has_many :services
  has_many :specialists, through: :services
  
  validates_presence_of :client_name
  validates_presence_of :client_phone_number
  
  accepts_nested_attributes_for :services, allow_destroy: true
  
end
