require 'rails_helper'

RSpec.describe ServicesController, type: :request do

  it "index" do
    service_1 = Service.create(name:"test", price: 1100)
    service_2 = Service.create(name:"test2", price: 1101)
    get "/services"
    expect(assigns(:services)).to contain_exactly *[ service_1, service_2 ]  
  end
  
  it "new" do
    get "/services/new"
    expect(response).to be_ok
  end
  
  describe "create" do
    
    it "success" do
      post "/services", params: {
        service: {
          name: "Testname",
          price: 1100
        }
      }
      expect(response).to be_redirect
      expect(Service.last.name).to eq "Testname"
    end
    
    it "failure" do
      post "/services", params: {
        service: {
          name: "",
          price: 1100
        }
      }
      expect(Service.count).to eq 0
    end
  end
  
  
  describe "update" do
    
    it "success" do
      service = Service.create(name: "test", price: 1100)
      patch "/services/#{service.id}", params: {
        service: {
          name: "updated"
        }
      }
      expect(service.reload.name).to eq "updated"
    end
    
    it "failure" do
      service = Service.create(name: "test", price: 1100)
      patch "/services/#{service.id}", params: {
        service: {
          name: ""
        }
      }
      expect(service.reload.name).to eq "test"
    end
    
  end
  
  it "edit" do
    service = Service.create(name: "test", price: 1100)
    get "/services/#{service.id}/edit"
    expect(assigns(:service)).to eq service
  end
  
  it "delete" do
    service = Service.create(name: "test", price: 1100)
    expect { delete "/services/#{service.id}" }.to change{ Service.count }.from(1).to(0)
  end

end
