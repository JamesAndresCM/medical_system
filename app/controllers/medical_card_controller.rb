class MedicalCardController < ApplicationController
  load_and_authorize_resource param_method: :medical_params
  before_action :set_medical, only: %i[edit update destroy show]
  before_action :respond_to_html, only: %i[edit destroy create]

  def show
    @medical_history = MedicalHistory.where(medical_card_id: @medical_card).ordenados
  end

  def new
   @medical_card = MedicalCard.new
  end

  def create
    @medical_card = MedicalCard.new(medical_params)
    if @medical_card.save
      respond_to do |format|
        format.js {}
      end
    end
  end

  def edit; end

  def update
    if @medical_card.update(medical_params)
      respond_to do |format|
        format.js {}
      end
    end
  end

  private

  def set_medical
    @medical_card = MedicalCard.find(params[:id])
  end

  def medical_params
    params.require(:medical_card).permit(:diagnostico_user, :ciudad, :edad, :peso, :estatura, :alergia, :user_id)
  end

  def respond_to_html
    respond_to do |format|
      format.html { redirect_to appointments_path, notice: 'error pagina no encontrada' }
      format.js {}
    end
  end
end
