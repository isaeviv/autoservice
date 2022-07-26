class Service < ApplicationRecord
  belongs_to :order
  belongs_to :specialist, optional: true
  belongs_to :category, optional: true
  
  validates_presence_of :name
end
