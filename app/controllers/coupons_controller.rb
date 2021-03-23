class CouponsController < ApplicationController
  before_action :coupon_find, only: %i[disable activate]

  def disable
    @coupon.update(status: :disabled)
    redirect_to promotion_path(@coupon.promotion), notice: t('.success', coupon_code: @coupon.code)
  end

  def activate
    @coupon.update(status: :active)
    redirect_to promotion_path(@coupon.promotion), notice: t('.success', coupon_code: @coupon.code)
  end

  private

  def coupon_find
    @coupon = Coupon.find(params[:id])
  end

  def coupon_params
    coupon = params.require(:coupon).permit(
      :code,
      :promotion
    )

  end

end