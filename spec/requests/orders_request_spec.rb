require 'rails_helper'

RSpec.describe "Orders", type: :request do
  
  before do
    sign_in @user = User.create(email: "test@example.com", password: "password")
  end
  
  it "index" do
    order_1 = create(:order)
    order_2 = create(:order)
    get "/orders"
    expect(assigns(:orders)).to contain_exactly *[ order_1, order_2 ]  
  end
  
  it "new" do
    get "/orders/new"
    expect(response).to be_ok
  end
  
  describe "create" do
    
    let(:client)  { create :client }
    let(:specialist)  { create :specialist }
    let(:category) { create :category }
  
    it "success" do
      expect{ 
        post "/orders", params: {
          order: {
            client_id: client.id,
            description: "order description",
            services_attributes:{
              Time.now.to_i => {
                name: "service name",
                specialist_id: specialist.id,
                price: 500,
                category_id: category.id
              }
            }
          }
        }
      }.to change{ Order.count }
      expect(response).to be_redirect
      order = Order.last
      expect(order.client).to eq client
      expect(order.services.last.name).to eq "service name"
    end
    
    it "failure" do
      post "/orders", params: {
        order: {
          client_name: "Testname",
          client_phone_number: ""
        }
      }
      expect(Order.count).to eq 0
    end
  end
  
  
  describe "update" do
    
    let(:client_1){ create(:client) }
    let(:client_2){ create(:client) }
    let(:order){ create(:order, client: client_1) }

    it "success" do
      expect{ 
        patch "/orders/#{order.id}", params: {
          order: {
            client_id: client_2.id
          }
        }
      }.to change{ order.reload.client }.from(client_1).to(client_2)
    end
    
    it "failure" do
      patch "/orders/#{order.id}", params: {
        order: {
          client_id: ""
        }
      }
      expect(order.reload.client).to eq client_1
    end
    
  end
  
  it "edit" do
    order =create(:order)
    get "/orders/#{order.id}/edit"
    expect(assigns(:order)).to eq order
  end
  
  it "delete" do
    order = create(:order)
    expect { delete "/orders/#{order.id}" }.to change{ Order.count }.from(1).to(0)
  end
  
  describe "filtering" do
    
    before do
      @order_1 = create :order_with_services
      @client = create :client
      @order_2 = create :order, client: @client
    end
    
    it "by client" do
      get "/orders", params: {
        client_id: @client.id
      }
      expect(assigns :orders).to include @order_2
      expect(assigns :orders).not_to include @order_1
    end
    
    it "by price" do
      get "/orders", params: {
        price_start: "9900",
        price_end: "10100"
      }
      expect(assigns :orders).to include @order_1
      expect(assigns :orders).not_to include @order_2
    end
    
  end
  
end
