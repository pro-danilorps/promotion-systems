require 'test_helper'

class ApiTest < ActionDispatch::IntegrationTest
  
  def setup
    user = create_user
    Promotion.create!(
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
    coupon = Coupon.create!(code: 'NATAL10-0001', promotion: promotion)

    get "/api/v1/coupons/#{coupon.code}"

    assert_response 200
  end
end