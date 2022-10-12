FactoryBot.define do
  
  factory :order do
    description { "Приехал на колымаге. Ругался матом и вонял куревом на администратора." }
    factory :order_with_services do |order|
      before :create do |order|
        order.services = build_list(:service, 2, order: order)
      end
    end
    client
  end
  
end