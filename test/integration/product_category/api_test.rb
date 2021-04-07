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

  test 'fail to show product category name and code' do
    get '/api/v1/product_categories/nothing', as: :json

    assert_response 404
  end

  test 'create a product category' do
    post api_v1_product_categories_path, params: {
      product_category: {
        name: 'Produtos de Jardinagem', code: 'JARDIM'
      }
    }, as: :json

    assert_response 201
  end

  test 'fail to create a product category' do
    post api_v1_product_categories_path, params: {
      product_category: {
        name: 'Produtos de Jardinagem'
      }
    }, as: :json

    assert_response 406
  end

  test 'edit a product category' do
    patch api_v1_product_category_path(code: 'ANTIFRA'), params: {
      product_category: {
        name: 'Produtos de Jardinagem', code: 'JARDIM'
      }
    }, as: :json

    assert_response 202
  end

  test 'fail to edit a product category' do
    patch api_v1_product_category_path(code: 'ANTIFRA'), params: {
      product_category: {
        name: 'Produtos de Jardinagem', code: ''
      }
    }, as: :json

    assert_response 406
  end

  test 'destroy a product category' do
    delete api_v1_product_category_path(code: 'ANTIFRA'), as: :json

    assert_response 204
  end

  test 'fail to destroy a product category' do
    delete api_v1_product_category_path(code: 'JARDIM'), as: :json

    assert_response 404
  end

  test 'route invalid without json header' do
    assert_raises ActionController::RoutingError do
      get '/api/v1/product_category/0'
    end
  end
end
