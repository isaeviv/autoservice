require 'rails_helper'

RSpec.describe WorkspacePolicy, type: :policy do
  subject { described_class }

  permissions :update?, :edit?, :destroy? do
    let!(:user) { create(:user) }
    let!(:owner) { create(:user) }
    let!(:workspace) { create(:workspace, owner: owner) }

    it "denies access if user is not owner of workspace" do
      expect(subject).not_to permit(user, workspace)
    end

    it "grants access if user is owner of workspace" do
      expect(subject).to permit(owner, workspace)
    end
  end

  describe '#resolve' do
    let(:scope) { Pundit.policy_scope!(user, Workspace) }
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }
    let!(:owned_workspace) { create(:workspace, owner: user) }
    let!(:other_workspace) { create(:workspace, owner: other_user) }
    context 'when user is owner of workspaces' do
      it 'includes workspaces where user is owner' do
        expect(scope).to include(owned_workspace)
        expect(scope).not_to include(other_workspace)
      end
    end

    context 'when user is member of workspaces' do
      let!(:membership_workspace) do
        ws = create(:workspace, owner: other_user)
        create(:workspace_membership, workspace: ws, user: user)
        ws
      end

      it 'includes workspaces where user is member' do
        expect(scope).to include(membership_workspace)
      end
    end

    context 'when user is both owner and member' do
      let!(:owned_workspace) { create(:workspace, owner: user) }
      let!(:membership_workspace) do
        ws = create(:workspace, owner: other_user)
        create(:workspace_membership, workspace: ws, user: user)
        ws
      end

      it 'returns unique records without duplicates' do
        expect(scope).to contain_exactly(owned_workspace, membership_workspace)
      end
    end
  end
end
