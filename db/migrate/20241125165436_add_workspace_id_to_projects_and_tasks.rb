class AddWorkspaceIdToProjectsAndTasks < ActiveRecord::Migration[8.0]
  def change
    add_column :tasks, :workspace_id, :integer
    add_column :projects, :workspace_id, :integer
  end
end
