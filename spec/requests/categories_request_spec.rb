require 'rails_helper'

RSpec.describe "Categories", type: :request do

  it "index" do
    category_1 = Category.create(name:"test")
    category_2 = Category.create(name:"test2")
    get "/categories"
    expect(assigns(:categories)).to contain_exactly *[ category_1, category_2 ]  
  end
  
  it "new" do
    get "/categories/new"
    expect(response).to be_ok
  end
  
  describe "create" do
    
    it "success" do
      post "/categories", params: {
        category: {
          name: "Testname"
        }
      }
      expect(response).to be_redirect
      expect(Category.last.name).to eq "Testname"
    end
    
    it "failure" do
      post "/categories", params: {
        category: {
          name: ""
        }
      }
      expect(Category.count).to eq 0
    end
  end
  
  
  describe "update" do
    
    it "success" do
      category = Category.create(name: "test")
      patch "/categories/#{category.id}", params: {
        category: {
          name: "updated"
        }
      }
      expect(category.reload.name).to eq "updated"
    end
    
    it "failure" do
      category = Category.create(name: "test")
      patch "/categories/#{category.id}", params: {
        category: {
          name: ""
        }
      }
      expect(category.reload.name).to eq "test"
    end
    
  end
  
  it "edit" do
    category = Category.create(name: "test")
    get "/categories/#{category.id}/edit"
    expect(assigns(:category)).to eq category
  end
  
  it "delete" do
    category = Category.create(name: "test")
    expect { delete "/categories/#{category.id}" }.to change{ Category.count }.from(1).to(0)
  end

end
