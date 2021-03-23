class Promotion < ApplicationRecord
  has_many :coupons

  validates :name, :code, :discount_rate,
            :coupon_quantity, :expiration_date,
            presence: true
  validates :code, :name, uniqueness: true

  
  def generate_coupons!
    return if coupons?
    
    (1..coupon_quantity).each do |coupon|
      coupon_code = "#{code}-#{"%04d" % coupon}"
      coupons.create!(code: coupon_code)
      #coupons.new(code: coupon_code)
    end
    #Coupon.insert_all([coupons])

  end

  # TODO: Fazer o insert_all funcionar corretamente
  
  private
  def coupons?
    coupons.any?
  end
end
