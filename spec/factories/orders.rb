FactoryBot.define do
  
  factory :order do
    client_name { "Жмышенко Валерий" }
    description { "Приехал на колымаге. Ругался матом и вонял куревом на администратора." }
    client_phone_number { "228228228" }
    factory :order_with_services do |order|
      before :create do |order|
        order.services = build_list(:service, 2, order: order)
      end
    end
  end
  
end