require "test_helper"

class ProductCategoryTest < ActiveSupport::TestCase
  test 'attributes cannot be blank' do
    product_category = ProductCategory.new

    refute product_category.valid?
    assert_includes product_category.errors[:name], 'Não pode ficar em branco'
    assert_includes product_category.errors[:code], 'Não pode ficar em branco'
  end

  test 'code must be uniq' do
    ProductCategory.create!(name: 'Produto Anti-Fraude', code: 'ANTIFRA')
    product_category = ProductCategory.new(code: 'ANTIFRA', name: 'Produto Anti-Fraude')

    refute product_category.valid?
    assert_includes product_category.errors[:code], 'Deve ser único'
    assert_includes product_category.errors[:name], 'Deve ser único'
  end
end
