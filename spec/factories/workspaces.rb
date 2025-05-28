FactoryBot.define do
  factory :workspace do
    sequence(:name) { |n| "Workspace_#{n}" }
    description { "MyText" }
    association :owner, factory: :user
  end
end
