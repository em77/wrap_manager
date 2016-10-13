class ClientActionPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @client_action = model
  end

  def show?
    @current_user.supervisor? || @current_user.id == @client_action.user_id
  end

  def destroy?
    @current_user.supervisor? || @current_user.id == @client_action.user_id
  end

  def edit?
    @current_user.supervisor? || @current_user.id == @client_action.user_id
  end

  def update?
    @current_user.supervisor? || @current_user.id == @client_action.user_id
  end
end
