require 'rails_helper'

RSpec.describe WorkspaceMembership, type: :model do
  context "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:workspace) }
  end

  context "validations" do
    let!(:user) { create :user }
    let!(:workspace) { create :workspace, owner: user }
    subject { workspace.memberships.first }
    it { is_expected.to validate_uniqueness_of(:user_id).scoped_to(:workspace_id) }
  end
end
