class PromotionsController < ApplicationController
  
  def index
    @promotions = Promotion.all
  end

  def show
    id = params[:id]
    @promotion = Promotion.find(id)
  end
  
  #private

#  def promotion_params
    #params.require(:promotion).permit(
      #:name,
      #:description:,
      #:code,
      #:discount_rate,
      #:coupon_quantity,
      #:expiration_date
    #)
  #end

end