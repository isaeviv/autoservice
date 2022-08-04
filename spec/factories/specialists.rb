FactoryBot.define do
  
  factory :specialist do
    sequence :name do |n| 
      "Вовчик_#{n}"
    end
    profession { "Бригадир" }
  end
  
end