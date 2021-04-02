class UsersController < ApplicationController
  before_action :user_find, only: %i[show]
  
  def show
    if owner?
      @title = "Seu perfil"
      @edit = true
    else
      @title = "Perfil de #{@user.name}"
      @edit = false
    end
  end

  private

  def user_find
    @user = User.find(params[:id])
  end

  def owner?
    params_id = params[:id].to_i
    user_id = current_user.id
    params_id == user_id
  end
end