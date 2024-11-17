FactoryBot.define do
  factory :user, class: User do
    sequence :email do |n|
      "example_#{n}@example.com"
    end

    password { "password" }
    name { "Валерий" }
    surname { "Жмышенко" }
    patronymic { "Альбертович" }
  end
end
