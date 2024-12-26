FactoryBot.define do
  factory :task do
    title { "Title" }
    description { "Description" }
    association :user
    association :project
    association :workspace
    
    after(:build) do |task|
      task.workspace ||= task.project.workspace
      task.user ||= task.workspace.owner
    end
  end
end
