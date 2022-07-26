class Service < ApplicationRecord
  belongs_to :order
  belongs_to :specialist
  
  validates_presence_of :name
end
