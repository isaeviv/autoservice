class Workspace < ApplicationRecord
  belongs_to :owner, class_name: "User", foreign_key: :user_id
  has_many :memberships, class_name: "WorkspaceMembership", dependent: :destroy
  has_many :members, through: :memberships, source: :user
  has_many :projects, dependent: :destroy
  has_many :tasks, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  after_create :create_owner_membership

  private

    def create_owner_membership
      memberships.create!(user: owner)
    end
end
