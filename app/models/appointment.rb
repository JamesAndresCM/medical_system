class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :doctor
  belongs_to :time_slot
  attr_accessor :specialty_id

  # validaciones
  validates_numericality_of :doctor_id
  validates_numericality_of :user_id
  validates_presence_of :appointment_date
  validates_numericality_of :time_slot_id

  # ordeno registros
  scope :ordenados, -> {order(appointment_date: :desc)}
  scope :week_appointments, -> {where("appointment_date >= ?", Date.today.at_beginning_of_week)}

  # metodo que recibe hash extra retorna tipo de usuario + fecha
  # TODO: fix this or refactor
  def self.get_type_user(type_user, id_user, args = {})
    if args.empty?
      where("#{type_user}": id_user)
    else
      where("#{type_user}": id_user, appointment_date: args)
    end
  end

  # devuelve doctores junto a su relacion
  def self.user_appointment_data
    joins(:doctor => :specialty).
        joins(:time_slot).select(:rut,:username,:last_name,:last_name_mother,:phone_number,:name,:appointment_date,:start_time,:end_time,:id)
  end

  # devuelve usuarios junto a su relacion
  def self.doctor_appointment_data
    left_joins(:user => :medical_card).
        joins(:time_slot).select(:rut,:username,:last_name,:last_name_mother,:phone_number,:appointment_date,:start_time,:end_time,:'medical_cards.id',:user_id)
  end

  # metodo que devuelve appointments diarios
  def self.doctor_today
    where(appointment_date: Date.current)
  end


  # metodo que devuelve appointments mes
  def self.user_month_select(month)
    where('extract(month from appointment_date) = ? and extract(year from appointment_date) = ?', month, DateTime.now.year)
  end

  # metodo que devuelve mes actual
  def self.user_month
    where('appointment_date BETWEEN ? AND ?', Date.current.beginning_of_month,
          Date.current.end_of_month)
  end

  # devuelve los 3 doctores con mayores atenciones
  def self.three_doctor
    find_by_sql("select appointments.doctor_id, name, doctors.rut, username, last_name, last_name_mother,email, phone_number, count(appointments.doctor_id) maximo from doctors inner join appointments on appointments.doctor_id=doctors.id inner join specialties on doctors.specialty_id=specialties.id group by doctors.rut, username, name, email, phone_number, last_name,last_name_mother, doctor_id order by maximo desc limit 3")
  end
end
