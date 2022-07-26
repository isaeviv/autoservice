class Category < ApplicationRecord
  has_many :service
  
  validates_presence_of :name
end
