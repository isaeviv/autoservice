class Specialist < ApplicationRecord
  has_many :service
  has_many :order, through: :service
  
  validates_presence_of :name
end
