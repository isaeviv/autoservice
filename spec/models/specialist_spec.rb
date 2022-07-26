require 'rails_helper'

RSpec.describe Specialist, type: :model do
  it { should have_many :service }
  it { should have_many(:order).through(:service) }
  it { should validate_presence_of :name }
end
