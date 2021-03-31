class Promotion < ApplicationRecord
  belongs_to :user
  has_many :coupons
  has_one :promotion_approval

  validates :name, :code, :discount_rate,
            :coupon_quantity, :expiration_date,
            presence: true
  validates :code, :name, uniqueness: true

  
  def generate_coupons!
    return if coupons?

    (1..coupon_quantity).each do |coupon|
      coupon_code = "#{code}-#{"%04d" % coupon}"
      coupons.create!(code: coupon_code)
    end

  end

  def self.search_exact(query)
    where('name = ?', query)
  end

  def self.search_partial(query)
    return [] if query==""
    where('name LIKE ?', "%#{query}%")
  end

  # TODO: Fazer o insert_all funcionar corretamente
  
  private
  def coupons?
    coupons.any?
  end
end
