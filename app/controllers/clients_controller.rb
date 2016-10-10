class ClientsController < ApplicationController
  before_action :require_login
  before_action :set_client, only: [:show, :edit, :update, :destroy]
  before_action :set_referer, only: [:destroy, :edit, :new]
  # after_action :verify_authorized

  attr_accessor :client, :clients, :client_actions
  helper_method :client, :clients, :client_actions

  def index
    @clients = Client.all
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

  private
    def set_client
      @client = Client.find(params.require(:id))
    end

    def client_params
      params.require(:client).permit(:name)
    end
end
