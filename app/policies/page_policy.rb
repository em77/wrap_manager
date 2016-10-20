class PagePolicy < Struct.new(:user, :page)
  attr_reader :user, :model

  def initialize(current_user, model)
    @user = current_user
    @page = model
  end

  def statistics?
    @user.supervisor?
  end
end
