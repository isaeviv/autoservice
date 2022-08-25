require 'rails_helper'

RSpec.describe "Services", type: :request do
  
  before do
    sign_in @user = User.create(email: "test@example.com", password: "password")
    @order = Order.create(client_name:"test", client_phone_number:"8 984 382 12 32")
    @specialist = Specialist.create(name:"test", profession: "автоэлектрик")
  end

  it "index" do
    service_1 = Service.create(name:"test", price: 1100, order: @order, specialist: @specialist)
    service_2 = Service.create(name:"test2", price: 1101, order: @order, specialist: @specialist)
    get "/services"
    expect(assigns(:services)).to contain_exactly *[ service_1, service_2 ]  
  end
  
  # it "new" do
  #   get "/services/new"
  #   expect(response).to be_ok
  # end
  # 
  # describe "create" do
  # 
  #   it "success" do
  #     post "/services", params: {
  #       service: {
  #         name: "Testname",
  #         price: 1100,
  #         order_id: @order.id,
  #         specialist_id: @specialist.id
  #       }
  #     }
  #     expect(response).to be_redirect
  #     expect(Service.last.name).to eq "Testname"
  #   end
  # 
  #   it "failure" do
  #     post "/services", params: {
  #       service: {
  #         name: "",
  #         price: 1100
  #       }
  #     }
  #     expect(Service.count).to eq 0
  #   end
  # end
  # 
  # 
  # describe "update" do
  # 
  #   it "success" do
  #     service = Service.create(name: "test", price: 1100, order: @order, specialist: @specialist)
  #     patch "/services/#{service.id}", params: {
  #       service: {
  #         name: "updated"
  #       }
  #     }
  #     expect(service.reload.name).to eq "updated"
  #   end
  # 
  #   it "failure" do
  #     service = Service.create(name: "test", price: 1100, order: @order, specialist: @specialist)
  #     patch "/services/#{service.id}", params: {
  #       service: {
  #         name: ""
  #       }
  #     }
  #     expect(service.reload.name).to eq "test"
  #   end
  # 
  # end
  
  # it "edit" do
  #   service = Service.create(name: "test", price: 1100, order: @order, specialist: @specialist)
  #   get "/services/#{service.id}/edit"
  #   expect(assigns(:service)).to eq service
  # end
  
  it "delete" do
    service = Service.create(name: "test", price: 1100, order: @order, specialist: @specialist)
    expect { delete "/services/#{service.id}" }.to change{ Service.count }.from(1).to(0)
  end
  
  describe "filtering" do
    
    before do
      @category_1 = create :category, name: "Тунеядство"
      @category_2 = create :category, name: "Починка"
      @specialist_1 = create :specialist, name: "Васёк", profession: "Работяга"
      @specialist_2 = create :specialist, name: "Игорёк", profession: "Столяр"
      @order_1 = create :order, client_name: "Client_1"
      @order_2 = create :order, client_name: "Client_2"
      @service_1 = create :service, name: "Сходить на перекур", category: @category_1, order: @order_1, price: 100, specialist: @specialist_1
      @service_2 = create :service, name: "Починить всё", category: @category_2, order: @order_2, price: 500, specialist: @specialist_2
    end
    
    it "by specialist name" do
      get "/services", params: {
        specialist: @specialist_1.id
      }
      expect(assigns :services).to include @service_1
      expect(assigns :services).not_to include @service_2
    end
    
    it "by price" do
      get "/services", params: {
        price_start: "0",
        price_end: "200"
      }
      expect(assigns :services).to include @service_1
      expect(assigns :services).not_to include @service_2
    end
    
    it "by category" do
      get "/services", params: {
        category: @category_1.id
      }
      expect(assigns :services).to include @service_1
      expect(assigns :services).not_to include @service_2
    end
    
    it "by order" do
      get "/services", params: {
        order: @order_1.id
      }
      expect(assigns :services).to include @service_1
      expect(assigns :services).not_to include @service_2
    end
    
  end

end
