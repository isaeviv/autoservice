class WorkspacePolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
     # Вариант 1: Если workspace принадлежит пользователю или он участник
     scope.joins("LEFT JOIN workspace_memberships ON workspaces.id = workspace_memberships.workspace_id")
      .where("workspaces.user_id = ? OR workspace_memberships.user_id = ?", user.id, user.id)
    end
  end

  def create?
    true
  end

  def edit?
    record.user_id == user.id
  end

  def update?
    edit?
  end

  def show?
    user.workspace_memberships.find_by(workspace_id: record.id).present?
  end

  def destroy?
    edit?
  end
end
