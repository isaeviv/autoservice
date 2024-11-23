class Project < ApplicationRecord
  belongs_to  :user
  has_many    :tasks
  validates_presence_of :name
  has_rich_text :description
end
