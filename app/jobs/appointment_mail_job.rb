class AppointmentMailJob < ApplicationJob
  queue_as :default

  def perform(appointment)
    @appointment = appointment
    AppointmentMailer.received_patient(@appointment).deliver_later
  end
end
