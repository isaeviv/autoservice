class Order < ApplicationRecord
  
  has_many :services
  has_many :specialists, through: :services
  
  validates_presence_of :client_name
  validates_presence_of :client_phone_number
  
  before_create :set_price
  before_update :set_price
  
  accepts_nested_attributes_for :services, allow_destroy: true
  
  def set_price
    self.price = 0
    self.services.each do |service|
      self.price += service.price
    end
  end
  
end
