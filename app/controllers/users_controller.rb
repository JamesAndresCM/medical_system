class UsersController < ApplicationController
  before_action :user_permited_parameters, only: [:update]
  before_action :set_user, only: %i[edit update destroy]
  before_action :respond_to_html, only: %i[edit new update destroy]
  load_and_authorize_resource

  def index
    @users = User.where.not(id: current_user.id)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      respond_to do |format|
        format.js {}
      end
    end
  end

  def edit; end

  def update

    if @user.update(user_params) and current_user.user?
      bypass_sign_in(@user) #al hacer update con ajax mantiene la session
      respond_to do |format|
        format.js {}
      end
    end
  end

  def destroy
    if @user.destroy
      respond_to do |format|
        format.js {}
      end
    end
  end

  private

  def user_permited_parameters
    params[:user].delete(:password) if params[:user][:password].blank?
    params[:user].delete(:password_confirmation) if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :username, :password, :password_confirmation, :role,:remove_avatar, :avatar, :avatar_cache, :last_name, :last_name_mother,:phone_number,:rut)
  end

  def respond_to_html
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'not found' }
      format.js {}
    end
  end
end
