require 'rails_helper'

RSpec.describe 'Product Category API Tests' do
  it 'show product category name and code' do
    product_category = Fabricate(:product_category)

    get "/api/v1/product_categories/#{product_category.code}", as: :json
    body = JSON.parse(response.body, symbolize_names: true)

    expect(response).to have_http_status(:success)
    expect(body[:name]).to eq(product_category.name.to_s)
    expect(body[:code]).to eq(product_category.code.to_s)
  end

  it 'fail to show product category name and code' do
    get '/api/v1/product_categories/nothing', as: :json

    expect(response).to have_http_status(404)
  end

  it 'create a product category' do
    post api_v1_product_categories_path, params: {
      product_category: {
        name: 'Produtos de Jardinagem', code: 'JARDIM'
      }
    }, as: :json

    expect(response).to have_http_status(201)
  end

  it 'fail to create a product category' do
    post api_v1_product_categories_path, params: {
      product_category: {
        name: 'Produtos de Jardinagem'
      }
    }, as: :json

    expect(response).to have_http_status(406)
  end

  it 'edit a product category' do
    Fabricate(:product_category, code: 'ANTIFRA')
    patch api_v1_product_category_path(code: 'ANTIFRA'), params: {
      product_category: {
        name: 'Produtos de Jardinagem', code: 'JARDIM'
      }
    }, as: :json

    expect(response).to have_http_status(202)
  end

  it 'fail to edit a product category' do
    Fabricate(:product_category, code: 'ANTIFRA')
    patch api_v1_product_category_path(code: 'ANTIFRA'), params: {
      product_category: {
        name: 'Produtos de Jardinagem', code: ''
      }
    }, as: :json

    expect(response).to have_http_status(406)
  end

  it 'destroy a product category' do
    Fabricate(:product_category, code: 'ANTIFRA')
    delete api_v1_product_category_path(code: 'ANTIFRA'), as: :json

    expect(response).to have_http_status(204)
  end

  it 'fail to destroy a product category' do
    delete api_v1_product_category_path(code: 'JARDIM'), as: :json

    expect(response).to have_http_status(404)
  end

  it 'route invalid without json header' do
    assert_raises ActionController::RoutingError do
      get '/api/v1/product_category/0'
    end
  end
end
