require 'test_helper'

class ApiTest < ActionDispatch::IntegrationTest
  
  def setup
    user = create_user
    @promotion = Promotion.create!(
      name: 'Natal',
      description: 'Promoção de Natal',
      code: 'NATAL10',
      discount_rate: 10,
      coupon_quantity: 100,
      expiration_date: '22/12/2033',
      user: user
    )
    Promotion.create!(
      name: 'Cyber Monday',
      coupon_quantity: 100,
      description: 'Promoção de Cyber Monday',
      code: 'CYBER15',
      discount_rate: 15,
      expiration_date: '22/12/2033',
      user: user
    )
  end
  
  test 'show coupon' do
    coupon = Coupon.create!(code: 'NATAL10-0001', promotion: @promotion)

    get "/api/v1/coupons/#{coupon.code}", as: :json

    assert_response :success
    body = JSON.parse(response.body, symbolize_names: true)
    assert_equal @promotion.discount_rate.to_s, body[:discount_rate]
  end

  test 'show coupon not found ' do
    get '/api/v1/coupons/0', as: :json

    assert_response :not_found, as: :json
  end
end
