require 'rails_helper'

RSpec.describe 'Product Category Model Test' do
 it 'attributes cannot be blank' do
    product_category = ProductCategory.new

    expect(product_category.valid?).not_to eq(true)
    expect(product_category.errors[:name]).to include('não pode ficar em branco')
    expect(product_category.errors[:code]).to include('não pode ficar em branco')
  end

  it 'name and code must be uniq' do
    Fabricate(:product_category, name: 'Produto Anti-Fraude', code: 'ANTIFRA')
    product_category = ProductCategory.new(name: 'Produto Anti-Fraude', code: 'ANTIFRA')

    expect(product_category.valid?).not_to eq(true)
    expect(product_category.errors[:name]).to include('deve ser único')
    expect(product_category.errors[:code]).to include('deve ser único')
  end
end
