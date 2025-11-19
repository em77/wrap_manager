class ClientsController < ApplicationController
  before_action :require_login
  before_action :set_client, only: [:show, :edit, :update, :destroy]
  before_action :set_referer, only: [:destroy, :edit, :new]
  after_action :verify_authorized, except: [:new, :create, :add_user_to_client,
    :unassigned]

  attr_accessor :client, :clients, :client_actions, :unassigned_clients
  helper_method :client, :clients, :client_actions, :unassigned_clients

  def index
    @clients = Client.all
    authorize Client
    @clients = @clients.reorder("last_name ASC")
    @clients = @clients.page(params[:page])
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
      flash[:success] = "New client added to unassigned list"
      redirect_to(unassigned_path)
    else
      flash[:error] = @client.errors.full_messages.to_sentence
      redirect_to root_path
    end
  end

  def edit
  end

  def update
    if @client.update(client_params)
      flash[:success] = "Client updated successfully"
      redirect_to client_path(client)
    else
      flash[:error] = "Log update failed"
      redirect_to client_path(client)
    end
  end

  def destroy
    client.destroy
    flash[:error] = "Client deleted"
    redirect_to root_path
  end

  def unassigned
    @unassigned_clients = Client.where(user_id: nil)
    @unassigned_clients = @unassigned_clients.reorder("last_name ASC")
    @unassigned_clients = @unassigned_clients.page(params[:page])
  end

  def add_user_to_client
    client = Client.find_by(id: params.require([:client_id]))
    client.user_id = current_user.id
    client.save
    flash[:success] = "#{client.first_name + " " + client.last_name} has been" +
      " assigned to you"
    redirect_to unassigned_path
  end

  def remove_user_from_client
    client = Client.find_by(id: params.require([:client_id]))
    authorize client
    client.user_id = nil
    client.save
    Appointment.destroy_all_future_appointments_for_client(client.id)
    flash[:error] = "#{client.first_name + " " + client.last_name}" +
      " has been unassigned from you and any" +
      " future appointments with them have been deleted."
    redirect_to root_path
  end

  private
    def set_client
      @client = Client.find(params.require(:id))
      authorize client
    end

    def client_params
      params.require(:client).permit(:first_name, :last_name)
    end
end
