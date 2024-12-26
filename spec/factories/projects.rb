FactoryBot.define do
  factory :project do
    name { "Title" }
    description { "Description" }
    association :user
    association :workspace
  end
end
