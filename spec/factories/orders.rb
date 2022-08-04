FactoryBot.define do
  
  factory :order do
    client_name { "Жмышенко Валерий" }
    description { "Приехал на колымаге. Ругался матом и вонял куревом на администратора." }
    client_phone_number { "228228228" }
    factory :order_with_services do |order|
      order.after_create { |o| create_list(:service, 2, order: o) }
    end
  end
  
end