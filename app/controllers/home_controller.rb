class HomeController < ApplicationController
  def index
    log_approvals
    log_promotions
    log_coupons
  end

  private

  def log_promotions
    promotions = Promotion.all
    @promotions_count = promotions.count
  end

  def log_approvals
    promotion_approvals = PromotionApproval.all
    @approved_promotions_count = promotion_approvals.count
  end

  def log_coupons
    coupons = Coupon.all
    @coupons_count = coupons.count
    @active_coupons_count = coupons.select { |coupon| coupon.status == 'active' }.count
    @disabled_coupons_count = coupons.select { |coupon| coupon.status == 'disabled' }.count
    @used_coupons_count = coupons.select { |coupon| coupon.status == 'used' }.count
  end
end
