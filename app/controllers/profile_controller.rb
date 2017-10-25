class ProfileController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def show
    @profile = @user
  end


  def update
      if params[:user]
        if @user.update(user_params)
        redirect_to @user, notice: 'User was successfully updated.'
        else
          @user.errors
          redirect_to @user, notice: "Format Error"
        end
      else
        redirect_to user_path(current_user), notice: "Cover or Avatar can't blank!"
      end
  end


  private
  def set_user
   begin
     @user = User.find(params[:id])
   rescue
     redirect_to user_path(current_user), notice: "User doesn't exists"
   end
  end

 #se agrega un if al final para preguntar antes del metodo update si el cover o avatar vienen vacios
  def user_params
     params.require(:user).permit(:email,:username,:avatar,:cover) if params[:user]
  end


end
