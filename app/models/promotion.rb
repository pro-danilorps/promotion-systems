class Promotion < ApplicationRecord
  belongs_to :user
  has_many :coupons, dependent: :restrict_with_error
  has_one :promotion_approval
  has_one :approver, through: :promotion_approval, source: :user

  validates :name, :code, :discount_rate,
            :coupon_quantity, :expiration_date,
            presence: true
  validates :code, :name, uniqueness: true

  # TODO: Fazer o Insert-All funcionar corretamente
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

  def coupons?
    coupons.any?
  end

  def approved?
    promotion_approval.present?
  end

  def can_approve?(current_user)
    user != current_user
  end

end
