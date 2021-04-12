require 'rails_helper'

RSpec.describe 'Promotion API Tests' do
  it 'show coupon' do
    promotion = Fabricate(:promotion)
    coupon = Coupon.create!(code: 'NATAL1', promotion: promotion)

    get "/api/v1/coupons/#{coupon.code}", as: :json

    expect(response).to have_http_status(:success)
    body = JSON.parse(response.body, symbolize_names: true)
    expect(body[:discount_rate]).to eq(coupon.discount_rate.to_s)
  end

  it 'show coupon not found ' do
    get '/api/v1/coupons/0', as: :json

    expect(response).to have_http_status(:not_found)
  end
end
