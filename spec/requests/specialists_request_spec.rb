require 'rails_helper'

RSpec.describe "Specialists", type: :request do

  it "index" do
    specialist_1 = Specialist.create(name:"test", profession: "автоэлектрик")
    specialist_2 = Specialist.create(name:"test2", profession: "автоэлектрик")
    get "/specialists"
    expect(assigns(:specialists)).to contain_exactly *[ specialist_1, specialist_2 ]  
  end
  
  it "new" do
    get "/specialists/new"
    expect(response).to be_ok
  end
  
  describe "create" do
    
    it "success" do
      post "/specialists", params: {
        specialist: {
          name: "Testname",
          profession: "автоэлектрик"
        }
      }
      expect(response).to be_redirect
      expect(Specialist.last.name).to eq "Testname"
    end
    
    it "failure" do
      post "/specialists", params: {
        specialist: {
          name: "",
          profession: "автоэлектрик"
        }
      }
      expect(Specialist.count).to eq 0
    end
  end
  
  
  describe "update" do
    
    it "success" do
      specialist = Specialist.create(name: "test", profession: "автоэлектрик")
      patch "/specialists/#{specialist.id}", params: {
        specialist: {
          name: "updated"
        }
      }
      expect(specialist.reload.name).to eq "updated"
    end
    
    it "failure" do
      specialist = Specialist.create(name: "test", profession: "автоэлектрик")
      patch "/specialists/#{specialist.id}", params: {
        specialist: {
          name: ""
        }
      }
      expect(specialist.reload.name).to eq "test"
    end
    
  end
  
  it "edit" do
    specialist = Specialist.create(name: "test", profession: "автоэлектрик")
    get "/specialists/#{specialist.id}/edit"
    expect(assigns(:specialist)).to eq specialist
  end
  
  it "delete" do
    specialist = Specialist.create(name: "test", profession: "автоэлектрик")
    expect { delete "/specialists/#{specialist.id}" }.to change{ Specialist.count }.from(1).to(0)
  end


end
