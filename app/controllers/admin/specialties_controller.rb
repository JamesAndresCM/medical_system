module Admin
  class SpecialtiesController < ApplicationController

    before_action :set_specialty, only: %i[edit update destroy]

    def index
      @specialties = Specialty.order('created_at DESC')
    end

    def edit; end

    def new
      @specialty = Specialty.new
    end

    def create
      @specialty = Specialty.new(specialty_params)
      respond_to do |format|
        format.js {} if @specialty.save
      end
    end

    def destroy
      respond_to do |format|
        format.js {} if @specialty.destroy
      end
    end

    def update
      respond_to do |format|
        format.js {} if @specialty.update(specialty_params)
      end
    end

    private

    def set_specialty
      @specialty = Specialty.find(params[:id])
    end

    def specialty_params
      params.require(:specialty).permit(:name)
    end

  end
end
