class AppointmentsController < ApplicationController
  before_action :require_login
  before_action :set_appointment, only: [:show, :edit, :update, :destroy]
  before_action :set_client, only: [:new, :edit]
  before_action :set_referer, only: [:destroy, :edit, :new]
  after_action :verify_authorized, except: [:index, :new, :create]

  attr_accessor :appointment, :appointments, :client
  helper_method :appointment, :appointments, :client

  def index
    @appointments = Appointment.where("user_id = ? AND start > ?",
      current_user.id, Time.zone.now)
  end

  def show
  end

  def new
    @appointment = Appointment.new
  end

  def create
    @appointment = Appointment.new(appointment_params)
    @appointment.user = current_user

    if @appointment.valid?
      @appointment.save
      redirect_to(appointments_path, notice: "Appointment created successfully")
    else
      flash[:error] = @appointment.errors.full_messages.to_sentence
      redirect_to(session.delete(:return_to))
    end
  end

  def edit
  end

  def update
    if @appointment.update(appointment_params)
      flash[:success] = "Appointment updated successfully"
      redirect_to my_calendar_path
    else
      flash[:error] = "Appointment update failed"
      redirect_to my_calendar_path
    end
  end

  def destroy
    appointment.destroy
    redirect_to my_calendar_path, notice: "Appointment deleted"
  end

  private
    def set_appointment
      @appointment = Appointment.find(params.require(:id))
      authorize appointment
    end

    def appointment_params
      params.require(:appointment).permit(:start, :client_id)
    end

    def set_client
      @client = Client.find(params.permit(:client_id)[:client_id])
    end
end
