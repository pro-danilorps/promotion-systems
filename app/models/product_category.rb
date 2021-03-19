class ProductCategory < ApplicationRecord
  validates :name, :code, presence: { message: 'Não pode ficar em branco' }
  validates :code, :name, uniqueness: { message: 'Deve ser único'}
end
