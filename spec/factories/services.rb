FactoryBot.define do
  
  factory :service do
    name { "Диагностика маслянного насоса" }
    price { 5000 }
    order
    specialist
    category
  end
  
end