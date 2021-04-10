require 'rails_helper'

RSpec.describe 'Promotion Flow it' do
  before do
    @user = Fabricate(:user)
  end

  it 'can create a promotion' do
    login_as(@user)
    post '/promotions', params: {
      promotion: { name: 'Cyber Monday', description: 'Promoção de Cyber Monday',
                   code: 'CYBER15', discount_rate: 15, coupon_quantity: 5,
                   expiration_date: '22/12/2033', user: @user }
    }

    expect(response).to redirect_to(promotion_path(Promotion.last))
    follow_redirect!
    assert_select 'h3', 'Cyber Monday'
  end

  it 'cannot create a promotion without login' do
    post '/promotions', params: {
      promotion: { name: 'Cyber Monday', description: 'Promoção de Cyber Monday',
                   code: 'CYBER15', discount_rate: 15, coupon_quantity: 5,
                   expiration_date: '22/12/2033' }
    }

    expect(response).to redirect_to(new_user_session_path)
  end

  it 'cannot generate coupons without login' do
    promotion = Fabricate(:promotion)
    post generate_coupons_promotion_path(promotion)

    expect(response).to redirect_to(new_user_session_path)
  end

  it 'cannot update promotions without login' do
    promotion = Fabricate(:promotion)
    promotion[:name] = 'Natal2'

    patch promotion_path(promotion)

    expect(response).to redirect_to(new_user_session_path)
  end

  it 'cannot destroy promotions without login' do
    promotion = Fabricate(:promotion)
    delete promotion_path(promotion)

    expect(response).to redirect_to(new_user_session_path)
  end

  it 'cannot approve a promotion if owner' do
    promotion = Fabricate(:promotion)
    user = promotion.user
    login_as(user)

    post approve_promotion_path(promotion)

    expect(flash[:alert]).to eq('Ação inválida')
  end
end
