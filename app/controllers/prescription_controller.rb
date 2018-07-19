class PrescriptionController < ApplicationController
  load_and_authorize_resource
  before_action :set_prescription, only: %i[show edit destroy update prescription_pdf]
  before_action :prescription_patients, only: %i[new edit]
  before_action :prescription_params, only: %i[create update]
  before_action :respond_to_html, only: %i[edit new update destroy show]

  def index
    @prescription = Prescription.includes(:user, :doctor).prescription_doctor(current_doctor).ordenados
  end

  def new
    @prescription = Prescription.new
  end

  def show; end

  def edit; end

  def prescription_pdf
    respond_to do |format|
      format.pdf do
        render pdf: 'prescription',
               template: 'prescription/prescription_pdf'
      end
    end
  end

  def create
    @prescription = current_doctor.prescriptions.create(prescription_params)
    respond_to do |format|
      format.js{} if @prescription.save
    end
  end

  def destroy
    respond_to do |format|
      format.js {} if @prescription.destroy
    end
  end

  def update
    respond_to do |format|
      format.js {} if @prescription.update(prescription_params)
    end
  end

  private

  def prescription_patients
    @patients = current_doctor.appointments.ordenados.to_a.uniq(&:user_id)
  end

  def set_prescription
    @prescription = Prescription.find(params[:id])
  end

  def prescription_params
    params.require(:prescription).permit(:user_id, :doctor_id, :descripcion)
  end

  def respond_to_html
    respond_to do |format|
      format.html {
        redirect_to doctor_prescription_index_path,
                    notice: 'error pagina no encontrada'
      }
      format.js {}
    end
  end
end
