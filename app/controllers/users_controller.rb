class UsersController < ApplicationController
  before_action :zero_users_or_authenticated
  before_action :set_user, only: [:show, :destroy, :edit, :update, :my_calendar,
    :user_cp, :my_clients]
  after_action :verify_authorized

  attr_accessor :user, :users, :appointments, :unassigned_clients,
    :assigned_clients
  helper_method :user, :users, :appointments, :unassigned_clients,
    :assigned_clients

  def zero_users_or_authenticated
    unless User.count == 0 || current_user
      redirect_to root_path
      return false
    end
  end

  def index
    @users = User.all
    authorize users
  end

  def show
  end

  def user_cp
    @unassigned_clients = Client.where(user_id: nil)
    @unassigned_clients = @unassigned_clients.paginate(page: params[:page])
  end

  def my_clients
    @assigned_clients = Client.where(user_id: user.id)
    @assigned_clients = @assigned_clients.reorder(
      "last_name ASC")
    @assigned_clients = @assigned_clients.paginate(page: params[:page])
  end

  def my_calendar
    @appointments = Appointment.where(user_id: user.id)
  end

  def destroy
    user.destroy
    redirect_to users_path, notice: "User deleted"
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "User updated successfully"
      redirect_to users_path
    else
      redirect_to users_path, error: "User update failed"
    end
  end

  def new
    @user = User.new
    authorize user
  end

  def create
    @user = User.new(user_params)
    authorize user

    respond_to do |format|
      if user.save
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
      authorize user
    end

    def user_params
      params.require(:user).permit(:name, :email, :password,
        :password_confirmation, :role)
    end
end
