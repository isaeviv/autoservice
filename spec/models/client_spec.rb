require 'rails_helper'

RSpec.describe Client, type: :model do
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :second_name }
  it { should have_many :orders}
  it { should have_many :services}
end
