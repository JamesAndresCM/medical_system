class HomeController < ApplicationController
  before_action :authenticate!

  def index
    redirect_to("/admin/users") if current_user.admin?
    @user_index = Appointment.three_doctor
    @user_appointment_today = Appointment.get_type_user("user_id", current_user.id).user_appointment_data.week_appointments.ordenados
  end

  def unregistered; end


  private

  def authenticate!
    :authenticate_user! || :authenticate_doctor!
  end
end
