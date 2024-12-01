FactoryBot.define do
  factory :workspace do
    name { "MyString" }
    description { "MyText" }
    owner { user }
  end
end
