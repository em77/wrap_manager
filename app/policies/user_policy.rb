class UserPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model, client = nil)
    @current_user = current_user
    @user = model
    @client = client
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

  def remove_user_from_client?
    @current_user.supervisor? || @current_user.id == @client.user_id
  end
end
