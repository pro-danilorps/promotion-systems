class PromotionsController < ApplicationController
  
  def index
    @promotions = Promotion.all
  end

  def show
  end

end