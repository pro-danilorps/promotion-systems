class ProductCategory < ApplicationRecord
  has_and_belongs_to_many :promotions

  validates :name, :code, presence: { message: 'não pode ficar em branco' }
  validates :code, :name, uniqueness: { message: 'deve ser único' }
end
