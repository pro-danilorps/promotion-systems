class Coupon < ApplicationRecord
  belongs_to :promotion

  validates :code, :promotion_id, presence: true
  validates :code, uniqueness: true

  enum status: {
    active: 0,
    used: 1,
    disabled: 2,
    expired: 3
  }

  delegate :discount_rate, :expiration_date, to: :promotion

  def as_json(options = {})
    super ({ methods: :discount_rate }.merge(options))
  end

  def self.search(query)
    find_by('code = ?', query)
  end
end
