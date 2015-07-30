class UserPolicy < ApplicationPolicy
  def rails_admin?(action)
    return user.admin?
  end
end
