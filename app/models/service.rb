class Service < ApplicationRecord
  
  include Filterable
  
  belongs_to :order
  belongs_to :specialist, optional: true
  belongs_to :category, optional: true
  has_one    :client
  
  scope :filter_by_order, -> (order_id) { where order_id: order_id }
  scope :filter_by_price, -> (price) { where price: price }
  scope :filter_by_specialist, -> (specialist_id) { where specialist_id: specialist_id }
  scope :filter_by_category, -> (category_id) { where category_id: category_id }
  
  validates_presence_of :name
end
