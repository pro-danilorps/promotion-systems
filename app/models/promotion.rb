class Promotion < ApplicationRecord
  has_many :coupons

  validates :name, :code, :discount_rate,
            :coupon_quantity, :expiration_date,
            presence: { message: "não pode ficar em branco" }
  validates :code, :name, uniqueness: { message: "deve ser único"}

  
  def generate_coupons!
    (1..coupon_quantity).each do |coupon|
      coupon_code = "#{code}-#{"%04d" % coupon}"
      coupons.create!(code: coupon_code)
    end
  end

end
