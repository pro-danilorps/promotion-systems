require "rails_helper"

RSpec.describe 'Promotion API Tests' do
  
  it 'show coupon' do
    headers = { "ACCEPT" => "application/json" }
    coupon = Fabricate(:coupon)    
    byebug
    get "/api/v1/coupons/#{coupon.code}"

    expect(response).to have_http_status(:created)
    body = JSON.parse(response.body, symbolize_names: true)
    expect(body[:discount_rate]).to eq(coupon.discount_rate.to_s)
  end

  it 'show coupon not found ' do
    get '/api/v1/coupons/0', as: :json

    assert_response :not_found, as: :json
  end

end