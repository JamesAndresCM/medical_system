class AppointmentsController < ApplicationController
  load_and_authorize_resource
  before_action :appointment_params, only: [:create]
  after_action :update_time_slot, only: [:create]
  before_action :data, only: [:new]

  def index
    if current_user&.user?
      #@user_appointments = Appointment.get_type_user("user_id", current_user.id).user_month.ordenados
      @user_appointments = Appointment.user_appointment_data.get_type_user("user_id", current_user).user_month.ordenados
    elsif current_doctor.present?
      @doctor_appointments = Appointment.doctor_appointment_data.get_type_user("doctor_id", current_doctor).doctor_today.ordenados
    end
  end

  def new
    @appointment = Appointment.new
  end

  def availability_slot
    @doctor_time_slot = Doctor.available_doctor(params[:time_slot_id],
                                                params[:appointment_date])
    if @doctor_time_slot.empty?
      render json: { status: 200, message: 'not available slot' }
    else
      render json: @doctor_time_slot
    end
  end

  def doctor_specialty
    @doctor_specialty = Doctor.specialty_doctor(params[:specialty_id])
    if @doctor_specialty.empty?
      render json: { status: 200, message: 'doctor specialty not found' }
    else
      render json: @doctor_specialty
    end
  end

  def get_date_range
    if current_user&.user?
      month = params[:appointment_date].split("-")[1]
      @get_date_range = Appointment.user_appointment_data.get_type_user("user_id", current_user.id).user_month_select(month).ordenados
      render 'appointments/get_date_range.json.jbuilder'
    elsif current_doctor.present?
      @get_date_range = Appointment.doctor_appointment_data.get_type_user("doctor_id", current_doctor.id, params[:appointment_date]).ordenados
      render 'appointments/get_date_range.json.jbuilder'
    end
  end

  def create
    if current_user&.user?
      @appointment = current_user.appointments.create(appointment_params)
      # only mail not job -> AppointmentMailer.received_patient(@appointment).deliver_later
      # job to send email
      # AppointmentMailJob.set(wait: 20.seconds).perform_later(@appointment)
    elsif current_doctor.present?
      @appointment = current_doctor.appointments.create(appointment_params)
    end
    respond_to do |format|
      if @appointment.save
        format.html { redirect_to appointments_path, notice: 'Cita creada' }
      else
        format.html {
          redirect_to new_appointment_path,
                      notice: @appointment.errors
        }
      end
    end
  end

  private


  def appointment_params
    params.require(:appointment).permit(:appointment_date, :doctor_id,
                                        :time_slot_id, :specialty_id, :user_id)
  end

  def update_time_slot
    TimeSlot.find_by(id: appointment_params[:time_slot_id]).update(availability:
                                                                       false)
  end

  def data
    @specialties = Specialty.all
    @users = User.all
  end
end
