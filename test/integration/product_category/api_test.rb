require 'test_helper'

class ProductCategory::ApiTest < ActionDispatch::IntegrationTest
  def setup
    @product_category = ProductCategory.create!(
      name: 'Produto Anti-Fraude',
      code: 'ANTIFRA'
    )
  end
  
  test 'show product category name and code' do
    get "/api/v1/product_categories/#{@product_category.code}", as: :json

    assert_response :success
    body = JSON.parse(response.body, symbolize_names: true)
    assert_equal @product_category.name.to_s, body[:name]
    assert_equal @product_category.code.to_s, body[:code]
  end

  # test 'create a product category' do
  #   post "/api/v1/product_categories.name=Produto_Anti-Fraude&code=ANTIFRA"

  #   assert_response :success
  # end
end