require 'rails_helper'

RSpec.describe User, type: :model do
  context "associations" do
    it { should have_many(:tasks) }
    it { should have_many(:projects) }
  end

  context "validations" do
    it { should validate_presence_of(:email) }
    it { should allow_value("user@example.com").for(:email) }
    it { should_not allow_value("not-an-email").for(:email) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:surname) }
  end
end
