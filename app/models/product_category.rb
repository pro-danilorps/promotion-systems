class ProductCategory < ApplicationRecord
  has_many :promotions, dependent: :restrict_with_error
  has_many :users, through: :promotions

  validates :name, :code, presence: { message: 'não pode ficar em branco' }
  validates :code, :name, uniqueness: { message: 'deve ser único' }
end
