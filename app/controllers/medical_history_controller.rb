class MedicalHistoryController < ApplicationController
  before_action :set_medical_history, only: %i[edit update show destroy]
  before_action :respond_to_html, only: %i[edit new update destroy show]
  load_and_authorize_resource

  def show; end

  def edit; end

  def new
    @medical_history = MedicalHistory.new
  end

  def update
    respond_to do |format|
      format.js {} if @medical_history.update(medical_history_params)
    end
  end

  def create
    @medical_history = current_doctor.medical_histories.create(medical_history_params)
    respond_to do |format|
      format.js {} if @medical_history.save
    end
  end

  def destroy
    if @medical_history.destroy
      respond_to do |format|
        format.js {}
      end
    end
  end

  def set_medical_history
    @medical_history = MedicalHistory.find(params[:id])
  end

  def medical_history_params
    params.require(:medical_history).permit(:body, :medical_card_id)
  end

  def respond_to_html
    respond_to do |format|
      format.html { redirect_to appointments_path, notice: 'error pagina no encontrada' }
      format.js {}
    end
  end
end
