class Workspace < ApplicationRecord
  belongs_to :owner, class_name: 'User', foreign_key: :user_id
  has_many :workspace_memberships
  has_many :members, through: :workspace_memberships, source: :user
  has_many :projects
  has_many :tasks

  validates_presence_of :name
end
