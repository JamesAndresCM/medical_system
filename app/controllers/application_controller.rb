class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include DeviseWhitelist
  include CancanWarning
  before_action :redirect_authenticate_path

  private

  def current_ability
    @current_ability ||=
      if current_user
        Ability.new(current_user)
      elsif current_doctor
        DoctorAbility.new(current_doctor)
      end
  end

  def redirect_authenticate_path
    if current_user or current_doctor
      redirect_to root_path if request.original_fullpath =~ /sign_in/
    end
  end
end
