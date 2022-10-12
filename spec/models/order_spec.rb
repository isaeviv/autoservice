require 'rails_helper'

RSpec.describe Order, type: :model do
  it { should have_many :services }
  it { should have_many(:specialists).through(:services) }
  it { should validate_presence_of :client }
  
  it "has price after create" do
    @order = create :order, services: create_list(:service, 2, price: 500)
    expect(@order.price).to eq 1000
  end
  
  it "changes price" do
    @order = create :order, services: create_list(:service, 2, price: 500)
    @order.services << create(:service, price: 500, order: @order)
    @order.save
    expect(@order.reload.price).to eq 1500
  end
end
