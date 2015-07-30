class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  # TODO: Right now, this isn't being called I think. It would be called
  # if UserPolicy.rb used super. Not sure what actions are for what roles,
  # so I'll leave default as admin, and ignore methods in this file def.
  def rails_admin?(action)
    case action
      when :dashboard
        user.admin?
      when :index
        user.admin?
      when :show
        user.admin?
      when :new
        user.admin?
      when :edit
        user.admin?
      when :destroy
        user.admin?
      when :export
        user.admin?
      when :delete
        user.admin?
      when :show_in_app
        user.admin?
      when :bulk_delete
        user.admin?
      else
        raise ::Pundit::NotDefinedError, "Could not find #{action} for #{record}."
    end
  end

  def index?
    false
  end

  def show?
    scope.where(:id => record.id).exists?
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end
end
