class UsersController < ApplicationController
  before_action :zero_users_or_authenticated
  before_action :set_user, only: [:show, :destroy, :edit, :update]
  # after_action :verify_authorized

  attr_accessor :user, :users, :appointments
  helper_method :user, :users, :appointments

  def zero_users_or_authenticated
    unless User.count == 0 || current_user
      redirect_to root_path
      return false
    end
  end

  def index
    @users = User.all
    # authorize @users
  end

  def show
    # authorize @user
    @appointments = Appointment.where(user_id: current_user.id)
  end

  def destroy
    # authorize @user
    user.destroy
    redirect_to users_path, notice: "User deleted"
  end

  def edit
    # authorize @user
  end

  def update
    # authorize @user
    if @user.update(user_params)
      flash[:success] = "User updated successfully"
      redirect_to users_path
    else
      redirect_to users_path, error: "User update failed"
    end
  end

  def new
    @user = User.new
    # authorize @user
  end

  def create
    @user = User.new(user_params)
    # authorize @user

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice:
          "User created" }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_user
      @user = User.find(params.require(:id))
    end

    def user_params
      params.require(:user).permit(:name, :email, :password,
        :password_confirmation, :role)
    end
end
