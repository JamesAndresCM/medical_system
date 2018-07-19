class UserPrescriptionsController < ApplicationController
  authorize_resource class: false
  def index
    @prescription_user = Prescription.prescription_user(current_user).ordenados
  end
end