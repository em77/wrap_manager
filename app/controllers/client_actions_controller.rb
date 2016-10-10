class ClientActionsController < ApplicationController
  before_action :require_login
  before_action :set_client_action, only: [:show, :edit, :update, :destroy]
  before_action :set_referer, only: [:destroy, :edit, :new]
  before_action :set_client, only: [:new, :edit]
  # after_action :verify_authorized

  attr_accessor :client_action, :client
  helper_method :client_action, :client

  def new
    @client_action = ClientAction.new
  end

  def show
  end

  def create
    @client_action = ClientAction.new(client_action_params)
    @client = Client.find(params.require(:client_action)
      .permit(:client_id)[:client_id])

    @client.wrap_status = params.require(:client_action)
      .require(:client).permit(:wrap_status)[:wrap_status] if
        params.require(:client_action)[:client]

    client_action.user_name = current_user.name

    if @client_action.valid?
      @client.save
      @client_action.save
      redirect_to session.delete(:return_to),
        notice: "Action saved successfully"
    else
      flash[:error] = @client_action.errors.full_messages.to_sentence
      redirect_to session.delete(:return_to)
    end
  end

  def edit
  end

  def update
    if @client_action.update(client_action_params)
      flash[:success] = "Action updated successfully"
    else
      flash[:error] = "Action update failed"
    end
    redirect_to session.delete(:return_to)
  end

  def destroy
    client_action.destroy
    redirect_to session.delete(:return_to), notice: "Action deleted"
  end

  private
    def set_client_action
      @client_action = ClientAction.find(params.require(:id))
    end

    def set_client
      @client = Client.find(params.require(:client_id))
    end

    def client_action_params
      params.require(:client_action).permit(:wrap_session,
        :client_id, :user_name, :notes)
    end
end
