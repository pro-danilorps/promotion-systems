class HomeController < ApplicationController
  def index
    promotions = Promotion.all
    @promotions_count = promotions.count
    
    promotion_approvals = PromotionApproval.all
    @approved_promotions_count = promotion_approvals.count
    
    coupons = Coupon.all
    @coupons_count = coupons.count
    @active_coupons_count = coupons.select{ |coupon| coupon.status == 'active'}.count
    @disabled_coupons_count = coupons.select{ |coupon| coupon.status == 'disabled'}.count
    @used_coupons_count = coupons.select{ |coupon| coupon.status == 'used'}.count
  end
end