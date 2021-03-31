class Coupon < ApplicationRecord
  belongs_to :promotion

  validates :code, :promotion_id, presence: true
  validates :code, uniqueness: true

  enum status: {
    active: 0,
    used: 1,
    disabled: 2
  }

  def self.search(query)
    find_by('code = ?', query)
  end

end
