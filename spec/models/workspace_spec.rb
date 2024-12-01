require 'rails_helper'

RSpec.describe Workspace, type: :model do
  context "associations" do
    it { should belong_to(:owner) }
    it { should have_many(:workspace_memberships) }
    it { should have_many(:members) }
    it { should have_many(:tasks) }
    it { should have_many(:projects) }
  end

  context "validations" do
    it { should validate_presence_of(:name) }
  end
end
