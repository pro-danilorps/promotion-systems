class PromotionsController < ApplicationController

  def show
  
  end

  private

  def user_find
    @user = User.find(user_params)
  end

  def user_params
    params
      .require(:user)
      .permit(
        :name,
        :email
      )
  end

end