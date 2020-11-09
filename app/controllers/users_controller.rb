class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_user, only: [:show]

  def show
    @user = current_user
    @events = Event.where(admin: @user)
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:success] = "Your profile has been updated!"
      redirect_to user_path(@user.id)
    else
      flash.now[:alert] = "We cannot update your profile for the following reason(s):"
      render :edit
    end
  end

  private
  
  def user_params
    params.require(:user).permit(:first_name, :last_name, :description)
  end

  def check_user
    @user = User.find(params[:id])
    unless current_user.id == @user.id
      flash[:warning] = "Where are you going mate 😁?"
      redirect_to root_path
    end
  end
  
end
