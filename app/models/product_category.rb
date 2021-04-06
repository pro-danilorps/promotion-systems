class ProductCategory < ApplicationRecord
  has_many :promotions
  has_many :users, through: :promotions
      
  validates :name, :code, presence: { message: 'não pode ficar em branco' }
  validates :code, :name, uniqueness: { message: 'deve ser único'}
end
