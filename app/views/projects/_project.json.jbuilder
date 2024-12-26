json.extract! project, :id, :created_at, :updated_at
json.url workspace_project_url(@workspace, project, format: :json)
