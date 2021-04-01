require 'test_helper'

class FlowTest < ActionDispatch::IntegrationTest
  
  def setup 
    @user = create_user
    Promotion.create!(
      name: 'Natal',
      description: 'Promoção de natal',
      code: 'NATAL10',
      discount_rate: 15,
      coupon_quantity: 5,
      expiration_date: '22/12/2033',
      user: @user
    )
    @promotion = Promotion.last
  end

  test 'can create a promotion' do
    login_as @user
    post '/promotions', params: { 
      promotion: { name: 'Cyber Monday', description: 'Promoção de Cyber Monday',
      code: 'CYBER15', discount_rate: 15, coupon_quantity: 5, 
      expiration_date: '22/12/2033', user: @user }
    }

    assert_redirected_to promotion_path(Promotion.last)
    follow_redirect!
    assert_select 'h3', 'Cyber Monday'
  end

  test 'cannot create a promotion without login' do
    post '/promotions', params: { 
      promotion: { name: 'Cyber Monday', description: 'Promoção de Cyber Monday',
        code: 'CYBER15', discount_rate: 15, coupon_quantity: 5, 
        expiration_date: '22/12/2033' }
    }

    assert_redirected_to new_user_session_path
  end

  test 'cannot generate coupons without login' do
    post generate_coupons_promotion_path(@promotion)

    assert_redirected_to new_user_session_path
  end

  test 'cannot update promotions without login' do
    @promotion[:name] = 'Natal2'
  
    patch promotion_path(@promotion)

    assert_redirected_to new_user_session_path
  end

  test 'cannot destroy promotions without login' do
    delete promotion_path(@promotion)

    assert_redirected_to new_user_session_path
  end

  test 'cannot approve a promotion if owner' do
    login_as (@user)

    post approve_promotion_path(@promotion)

    assert_equal 'Ação inválida!', flash[:alert]
  end
end