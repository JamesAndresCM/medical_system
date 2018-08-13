class AppointmentMailer < ApplicationMailer

  default from: 'Clinica Médica <email_address>'
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.appointment_mailer.received.subject
  #
  def received_patient(appointment)
    @appointment = appointment

    mail to: appointment.user.email, subject: 'Cita Médica Confirmada'
  end
end
