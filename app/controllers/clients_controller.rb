class ClientsController < ApplicationController
  before_action :require_login
  before_action :set_client, only: [:show, :edit, :update, :destroy]
  before_action :set_referer, only: [:destroy, :edit, :new]
  after_action :verify_authorized, except: [:new, :create, :add_user_to_client]

  attr_accessor :client, :clients, :client_actions
  helper_method :client, :clients, :client_actions

  def index
    @clients = Client.all
    authorize Client
  end

  def show
    @client_actions = ClientAction.where(
      client_id: client.id).order(
      "updated_at desc")
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(client_params)

    if @client.valid?
      @client.save
      redirect_to(clients_path, notice: "Client created successfully")
    else
      flash[:error] = @client.errors.full_messages.to_sentence
      redirect_to(session.delete(:return_to))
    end
  end

  def edit
  end

  def update
    if @client.update(client_params)
      flash[:success] = "Client updated successfully"
      redirect_to clients_path
    else
      flash[:error] = "Log update failed"
      redirect_to clients_path
    end
  end

  def destroy
    client.destroy
    redirect_to clients_path, notice: "Client deleted"
  end

  def add_user_to_client
    client = Client.find_by_id(params.require([:client_id]))
    client.user_id = current_user.id
    client.save
    flash[:success] = "#{client.name} has been assigned to you"
    redirect_to user_cp_path(current_user)
  end

  def remove_user_from_client
    client = Client.find_by_id(params.require([:client_id]))
    authorize client
    client.user_id = nil
    client.save
    Appointment.destroy_all_future_appointments_for_client(client.id)
    flash[:error] = "#{client.name} has been unassigned from you and all" +
      " future appointments with them have been deleted."
    redirect_to my_clients_path(current_user)
  end

  private
    def set_client
      @client = Client.find(params.require(:id))
      authorize client
    end

    def client_params
      params.require(:client).permit(:name)
    end
end
