FactoryBot.define do
  factory :client do
    first_name { "First_#{id}" }
    second_name { "Last_#{id}" }
    patronymic { "Patromynic_#{id}" }
    phone_number { "82281337228" }
    additional_phone_number { "299160" }
    email { "client_#{id}@example.com" }
    adress { 
      { 
        city: "Абакан", 
        street: "Ленина", 
        building: "67", 
        room: "510" 
      } 
    }
  end
end
