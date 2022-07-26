 require 'rails_helper'

RSpec.describe OrdersController, type: :request do
  
  it "index" do
    order_1 = Order.create(client_name:"test", client_phone_number:"8 984 382 12 32")
    order_2 = Order.create(client_name:"test2", client_phone_number:"8 984 382 00 32")
    get "/orders"
    expect(assigns(:orders)).to contain_exactly *[ order_1, order_2 ]  
  end
  
  it "new" do
    get "/orders/new"
    expect(response).to be_ok
  end
  
  describe "create" do
    
    it "success" do
      post "/orders", params: {
        order: {
          client_name: "Testname",
          client_phone_number: "89873192832"
        }
      }
      expect(response).to be_redirect
      expect(Order.last.client_name).to eq "Testname"
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
    
    it "success" do
      order = Order.create(client_name: "test", client_phone_number: "7 983 198 3212")
      patch "/orders/#{order.id}", params: {
        order: {
          client_name: "updated"
        }
      }
      expect(order.reload.client_name).to eq "updated"
    end
    
    it "failure" do
      order = Order.create(client_name: "test", client_phone_number: "7 983 198 3212")
      patch "/orders/#{order.id}", params: {
        order: {
          client_name: ""
        }
      }
      expect(order.reload.client_name).to eq "test"
    end
    
  end
  
  it "edit" do
    order = Order.create(client_name: "test", client_phone_number: "7 983 198 3212")
    get "/orders/#{order.id}/edit"
    expect(assigns(:order)).to eq order
  end
  
  it "delete" do
    order = Order.create(client_name: "test", client_phone_number: "7 983 198 3212")
    expect { delete "/orders/#{order.id}" }.to change{ Order.count }.from(1).to(0)
  end
  
end
