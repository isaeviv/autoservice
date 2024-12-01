FactoryBot.define do
  factory :workspace_membership do
    workspace { workspace }
    user { user }
  end
end
