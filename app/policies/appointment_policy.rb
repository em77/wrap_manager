class AppointmentPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @appointment = model
  end

  def show?
    @current_user.supervisor? || @current_user.id == @appointment.user_id
  end

  def destroy?
    @current_user.supervisor? || @current_user.id == @appointment.user_id
  end

  def edit?
    @current_user.supervisor? || @current_user.id == @appointment.user_id
  end

  def update?
    @current_user.supervisor? || @current_user.id == @appointment.user_id
  end
end
