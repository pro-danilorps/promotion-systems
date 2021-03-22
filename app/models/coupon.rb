class Coupon < ApplicationRecord
  belongs_to :promotion

  validates :code, :promotion_id, presence: { message: 'Não pode ficar em branco'}
  validates :code, uniqueness: { message: 'Deve ser único'}

end
