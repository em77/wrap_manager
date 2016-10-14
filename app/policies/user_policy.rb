class UserPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @user = model
  end

  def index?
    @current_user.supervisor?
  end

  def show?
    @current_user.supervisor? || @current_user == @user
  end

  def destroy?
    @current_user.supervisor?
  end

  def edit?
    @current_user.supervisor?
  end

  def update?
    @current_user.supervisor?
  end

  def new?
    @current_user.supervisor?
  end

  def create?
    @current_user.supervisor?
  end

  def my_calendar?
    @current_user.supervisor? || @current_user == @user
  end

  def user_cp?
    @current_user.supervisor? || @current_user == @user
  end
end
