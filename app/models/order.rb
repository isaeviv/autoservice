class Order < ApplicationRecord
  
  include Filterable
  
  has_many :services
  has_many :specialists, through: :services
  belongs_to  :client
  
  validates_presence_of :client
  
  before_create :set_price
  before_update :set_price
  
  accepts_nested_attributes_for :services, allow_destroy: true
  
  scope :filter_by_client_id, -> (client_id) { where client_id: client_id }
  scope :filter_by_price, -> (price) { where price: price }
  
  def set_price
    self.price = 0
    self.services.each do |service|
      self.price += service.price
    end
  end
  
end
