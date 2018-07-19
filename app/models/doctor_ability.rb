class DoctorAbility
  include CanCan::Ability
  def initialize(doctor)
    can :manage, Doctor
    can :manage, MedicalCard
    can :manage, Appointment
    can :manage, MedicalHistory
    can :manage, :doctor_patient
    can :manage, TimeSlot
    can :manage, Prescription
  end
end