class ClientPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @client = model
  end

  def index?
    @current_user.supervisor?
  end

  def show?
    @current_user.supervisor? || @current_user.id == @client.user_id
  end

  def destroy?
    @current_user.supervisor? || @current_user.id == @client.user_id
  end

  def edit?
    @current_user.supervisor? || @current_user.id == @client.user_id
  end

  def update?
    @current_user.supervisor? || @current_user.id == @client.user_id
  end

  def remove_user_from_client?
    @current_user.supervisor? || @current_user.id == @client.user_id
  end
end
