require 'rails_helper'

RSpec.describe Specialist, type: :model do
  it { should have_many :services }
  it { should have_many(:orders).through(:services) }
  it { should validate_presence_of :name }
end
