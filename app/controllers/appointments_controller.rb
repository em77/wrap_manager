class AppointmentsController < ApplicationController
  before_action :require_login
  before_action :set_appointment, only: [:show, :edit, :update, :destroy]
  before_action :set_referer, only: [:destroy, :edit, :new]
  after_action :verify_authorized, except: :index, :new, :create

  attr_accessor :appointment, :appointments
  helper_method :appointment, :appointments

  def index
    @appointments = Appointment.where(user_id: current_user.id)
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
      redirect_to appointments_path
    else
      flash[:error] = "Log update failed"
      redirect_to appointments_path
    end
  end

  def destroy
    appointment.destroy
    redirect_to appointments_path, notice: "Appointment deleted"
  end

  private
    def set_appointment
      @appointment = Appointment.find(params.require(:id))
      authorize appointment
    end

    def appointment_params
      params.require(:appointment).permit(:start, :start_time, :start_date,
        :client_id, :ending, :ending_time, :ending_date)
    end
end
