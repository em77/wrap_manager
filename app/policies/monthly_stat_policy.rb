class MonthlyStatPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @monthly_stat = model
  end

  def index?
    @current_user.supervisor?
  end
end
