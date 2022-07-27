require 'rails_helper'

RSpec.describe Order, type: :model do
  it { should have_many :services }
  it { should have_many(:specialists).through(:services) }
  it { should validate_presence_of :client_name }
  it { should validate_presence_of :client_phone_number }
end
