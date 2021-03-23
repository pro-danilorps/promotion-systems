class Coupon < ApplicationRecord
  belongs_to :promotion

  validates :code, :promotion_id, presence: true
  validates :code, uniqueness: true

end
