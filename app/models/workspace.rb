class Workspace < ApplicationRecord
  belongs_to :owner, class_name: 'User', foreign_key: :user_id
  has_many :memberships, class_name: 'WorkspaceMembership'
  has_many :members, through: :memberships, source: :user
  has_many :projects
  has_many :tasks

  validates_presence_of :name

  after_create :create_owner_membership

  private

    def create_owner_membership
      memberships.create!(user: owner)
    end
end
