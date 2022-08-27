class Client < ApplicationRecord
  validates_presence_of :first_name, :second_name
  has_many  :orders
  has_many  :services
end
