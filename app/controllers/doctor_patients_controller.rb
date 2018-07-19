class DoctorPatientsController < ApplicationController
  authorize_resource class: false

  def index
    @appointments_patients = current_doctor.appointments.order('appointments.created_at DESC').left_outer_joins(:user => :medical_card).select(:rut,:user_id,:'medical_cards.id',:last_name,:last_name_mother,:phone_number,:doctor_id,:username,:medical_cards).to_a.uniq(&:user_id)
  end
end
