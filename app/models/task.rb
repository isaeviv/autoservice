class Task < ApplicationRecord
  belongs_to :user
  belongs_to :project, optional: true

  # has_many    :task_taggings, foreign_key: :autoservice_task_id
  # has_many    :tags, through: :task_taggings, foreign_key: :autoservice_task_id
  validates_presence_of :description
  has_rich_text :description

  enum :status, [:open, :in_progress, :suspended, :completed, :closed], default: :open
end
