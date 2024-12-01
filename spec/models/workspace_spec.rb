require 'rails_helper'

RSpec.describe Workspace, type: :model do
  context "associations" do
    it { should belong_to(:owner) }
    it { should have_many(:memberships) }
    it { should have_many(:members) }
    it { should have_many(:tasks) }
    it { should have_many(:projects) }
  end

  context "validations" do
    it { should validate_presence_of(:name) }
  end

  context "callbacks" do
    describe "creates membership after create workspace" do
      let(:user) { create :user }
      it { 
        expect { 
          Workspace.create(name: "test", owner: user) 
        }.to change { WorkspaceMembership.count }.by(1)
      }

      it 'and user is owner' do
        workspace = Workspace.create(name: "test", owner: user)
        expect(workspace.memberships.last.user).to eq user 
      end
    end
  end

end
