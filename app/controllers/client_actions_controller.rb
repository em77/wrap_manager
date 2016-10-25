class ClientActionsController < ApplicationController
  before_action :require_login
  before_action :set_client_action, only: [:show, :edit, :update, :destroy]
  before_action :set_referer, only: [:destroy, :edit, :new]
  before_action :set_client, only: [:new, :edit]
  after_action :verify_authorized, except: [:index, :new, :create]

  attr_accessor :client_action, :client
  attr_reader :original_wrap_status
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

    @original_wrap_status = client.wrap_status

    @client.wrap_status = params.require(:client_action)
      .require(:client).permit(:wrap_status)[:wrap_status] if
        params.require(:client_action)[:client]

    client_action.user_name = current_user.name

    if @client_action.valid?
      set_wrap_action
      @client.save
      @client_action.save
      flash[:success] = "Action saved successfully"
      redirect_to session.delete(:return_to)
    else
      flash[:error] = @client_action.errors.full_messages.to_sentence
      redirect_to session.delete(:return_to)
    end
  end

  def edit
  end

  def update
    @client = Client.find(params.require(:client_action)
      .permit(:client_id)[:client_id])

    set_original_wrap_status

    @client.wrap_status = params.require(:client_action)
      .require(:client).permit(:wrap_status)[:wrap_status] if
        params.require(:client_action)[:client]

    if @client_action.update(client_action_params)
      set_wrap_action
      @client.save
      @client_action.save
      flash[:success] = "Action updated successfully"
    else
      flash[:error] = "Action update failed"
    end
    redirect_to session.delete(:return_to)
  end

  def destroy
    client_action.destroy
    flash[:error] = "Action deleted"
    redirect_to session.delete(:return_to)
  end

  private
    def set_client_action
      @client_action = ClientAction.find(params.require(:id))
      authorize client_action
    end

    def set_client
      @client = Client.find(params.require(:client_id))
    end

    def set_wrap_action
      new_wrap_status = params.require(:client_action)
        .require(:client)
          .permit(:wrap_status)[:wrap_status] if
            params.require(:client_action)[:client]
      if (original_wrap_status == new_wrap_status) || new_wrap_status.nil?
        @client_action.wrap_action = :no_change
      else
        @client_action.wrap_action = new_wrap_status
      end
    end

    def set_original_wrap_status
      @original_wrap_status = client.wrap_status
    end

    def client_action_params
      params.require(:client_action).permit(:wrap_session,
        :client_id, :user_name, :notes, :wrap_action)
    end
end
