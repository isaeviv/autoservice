class Order < ApplicationRecord
  
  include Filterable
  
  has_many :services
  has_many :specialists, through: :services
  
  validates_presence_of :client_name
  validates_presence_of :client_phone_number
  
  before_create :set_price
  before_update :set_price
  
  accepts_nested_attributes_for :services, allow_destroy: true
  
  scope :filter_by_client_name, -> (client_name) { where client_name: client_name }
  scope :filter_by_price, -> (price) { where price: price }
  
  def set_price
    self.price = 0
    self.services.each do |service|
      self.price += service.price
    end
  end
  
end
