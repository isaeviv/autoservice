FactoryBot.define do
  factory :task do
    title { "Title" }
    description { "Description" }
    user
    project { create(:workspace, user: task_oner) }
    workspace { user }
  end
end
