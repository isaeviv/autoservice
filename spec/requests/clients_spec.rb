require 'rails_helper'

RSpec.describe "Clients", type: :request do
  
  before do
    sign_in @user = User.create(email: "test@example.com", password: "password")
  end
  
  it "index" do
    clients = create_list :client, 2
    get "/clients"
    expect(assigns(:clients)).to contain_exactly *clients
  end
  
  it "new" do
    get "/clients/new"
    expect(response).to be_ok
  end
  
  describe "create" do
    
    it "success" do
      post "/clients", params: {
        client: {
          first_name: "Eduard",
          second_name:  "Limonov",
          patronymic: "Viniaminovich",
          phone_number: "76666666666",
          adress:{
            city:     "Kcharkiv",
            street:   "Limonnaja",
            building: "45",
            room:     "100"
          }
        }
      }
      expect(response).to be_redirect
      expect(Client.last.first_name).to eq "Eduard"
    end
    
    it "failure" do
      post "/clients", params: {
        client: {
          first_name: ""
        }
      }
      expect(Client.count).to eq 0
    end
  end
  
  
  describe "update" do
    
    before do
      @client = create(:client, first_name: "test")
    end
    
    it "success" do
      patch "/clients/#{@client.id}", params: {
        client: {
          first_name: "updated"
        }
      }
      expect(@client.reload.first_name).to eq "updated"
    end
    
    it "failure" do
      patch "/clients/#{@client.id}", params: {
        client: {
          first_name: ""
        }
      }
      expect(@client.reload.first_name).to eq "test"
    end
    
  end
  
  it "edit" do
    client = create :client
    get "/clients/#{client.id}/edit"
    expect(assigns(:client)).to eq client
  end
  
  it "delete" do
    client = create :client
    expect { delete "/clients/#{client.id}" }.to change{ Client.count }.from(1).to(0)
  end
  
  
end
