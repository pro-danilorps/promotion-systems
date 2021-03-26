class PromotionsController < ApplicationController
  before_action :promotion_find, only: %i[show edit update generate_coupons]

  def index
    @promotions = Promotion.all
  end

  def show
  end
  
  def new
    @promotion = Promotion.new
  end

  def create
    @promotion = Promotion.new(promotion_params)
    if @promotion.save
      redirect_to @promotion
    else
      render :new
    end
  end

  def edit
  end

  def update

    if @promotion.update(promotion_params)
      redirect_to @promotion, notice: t('.success')
    else
      render :edit
    end
  end

  def destroy
    Promotion.destroy(params[:id])
    redirect_to promotions_path, notice: t('.success')
  end

  def generate_coupons
    @promotion.generate_coupons!
    if @promotion.coupons.any?
      redirect_to @promotion, notice: t('.success')
    else
      redirect_to @promotion, alert: t('.failure')
    end
  end
  
  private

  def promotion_find
    @promotion = Promotion.find(params[:id])
  end

  def promotion_params
    params.require(:promotion).permit(
      :name,
      :description,
      :code,
      :discount_rate,
      :coupon_quantity,
      :expiration_date
    )
  end

end