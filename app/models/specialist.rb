class Specialist < ApplicationRecord
  has_many :services
  has_many :orders, through: :services
  
  validates_presence_of :name
end
