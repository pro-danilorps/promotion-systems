class Coupon < ApplicationRecord
  belongs_to :promotion

  validates :code, :promotion_id, presence: { message: 'Não pode ficar em branco'}
  validates :code, uniqueness: { message: 'Deve ser único'}

  def self.generate_coupons(promotion_object)
    (1..promotion_object.coupon_quantity).each do |coupon|
      code = "#{promotion_object.code}-#{"%04d" % coupon}"
      create!(code: code, promotion: promotion_object)
    end
  end

end
