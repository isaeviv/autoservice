FactoryBot.define do
  factory :workspace do
    name { "MyString" }
    description { "MyText" }
    association :owner, factory: :user
  end
end
