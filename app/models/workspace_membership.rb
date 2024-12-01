class WorkspaceMembership < ApplicationRecord
  belongs_to :workspace
  belongs_to :user

  validates_uniqueness_of :user_id, scope: :workspace_id
end
