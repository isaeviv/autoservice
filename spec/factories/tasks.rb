FactoryBot.define do
  factory :task do
    title { "Title" }
    description { "Description" }
    user { user }
    project { project }
  end
end
