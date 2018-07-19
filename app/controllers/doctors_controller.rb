class DoctorsController < ApplicationController
  before_action :set_doctor, only: %i[edit update destroy]
  before_action :doctor_permited_parameters, only: %i[update create]
  before_action :respond_to_html, only: %i[edit new update destroy show]
  load_and_authorize_resource

  def index
    @doctors = Doctor.all
  end

  def new
    @doctor = Doctor.new
  end

  def create
    @doctor = Doctor.new(doctor_params)
    if @doctor.save
      respond_to do |format|
        format.js {}
      end
    end
  end

  def edit; end

  def show; end

  def update
    if @doctor.update(doctor_params) and current_doctor.present?
      bypass_sign_in(@doctor)
      respond_to do |format|
        format.js {}
      end
    end
  end

  def destroy
    if @doctor.destroy
      respond_to do |format|
        format.js {}
      end
    end
  end

  private

  def doctor_permited_parameters
    params[:doctor].delete(:password) if params[:doctor][:password].blank?
    params[:doctor].delete(:password_confirmation) if params[:doctor][:password].blank? && params[:doctor][:password_confirmation].blank?
  end

  def set_doctor
    @doctor = Doctor.find(params[:id])
  end

  def doctor_params
    params.require(:doctor).permit(:email, :username, :password, :password_confirmation, :remove_avatar, :avatar, :avatar_cache, :last_name, :last_name_mother,:phone_number, :specialty_id, :rut)
  end

  def respond_to_html
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'error pagina no encontrada' }
      format.js {}
    end
  end
end