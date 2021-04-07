class PromotionsController < ApplicationController
  before_action :promotion_find, only: %i[
    show edit update generate_coupons approve
  ]
  before_action :approval_ok?, only: %i[approve]

  def index
    @promotions = Promotion.all
  end

  def show
  end

  def new
    @promotion = Promotion.new
  end

  def create
    @promotion = current_user.promotions.new(promotion_params)
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

  def search
    @search_type = params[:search_type]
    @query = params[:query]
    @promotions = if @search_type == 'partial'
                    Promotion.search_partial(@query)
                  else
                    Promotion.search_exact(@query)
                  end
    render :index
  end

  def approve
    current_user.promotion_approvals.create!(promotion: @promotion)
    redirect_to @promotion, notice: t('.success', promotion_name: @promotion.name)
  end

  private

  def promotion_params
    params
      .require(:promotion)
      .permit(:name, :expiration_date, :description,
              :discount_rate, :code, :coupon_quantity)
  end

  def promotion_find
    @promotion = Promotion.find(params[:id])
  end

  def approval_ok?
    return if @promotion.can_approve?(current_user)
    redirect_to @promotion,
                alert: t('.failure')
  end
  
end