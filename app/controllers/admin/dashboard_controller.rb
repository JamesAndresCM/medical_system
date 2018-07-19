module Admin
  class DashboardController < ApplicationController
    authorize_resource class: false

    def index
      @users = User.where.not(id: current_user.id).ordenados
    end

    def index_doctors
      @doctors = Doctor.joins(:specialty).select(:id, :username, :last_name,
                                                 :last_name_mother,
                                                 :email, :rut, :phone_number,
                                                 :name).ordenados
    end
  end
end
