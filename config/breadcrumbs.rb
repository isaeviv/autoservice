crumb :workspaces do
  link "Workspaces", workspaces_path
end

crumb :workspace do |workspace|
  link workspace.name, workspace
  parent :workspaces
end

crumb :projects do |workspace|
  link "Projects", workspace_projects_path(workspace)
  parent :workspace, workspace
end

crumb :project do |workspace, project|
  link project.name, workspace_project_path(workspace, project)
  parent :projects, workspace
end

crumb :new_project do |workspace|
  link "New", "#"
  parent :projects, workspace
end

crumb :edit_project do |workspace, project|
  link "Edit", "#"
  parent :project, workspace, project
end



crumb :tasks do |workspace|
  link "Tasks", workspace_tasks_path(workspace)
  parent :workspace, workspace
end

crumb :task do |workspace, task|
  link task.title, workspace_task_path(workspace, task)
  parent :tasks, workspace
end

crumb :new_task do |workspace|
  link "New", "#"
  parent :tasks, workspace
end

crumb :edit_task do |workspace, task|
  link "Edit", "#"
  parent :task, workspace, task
end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).