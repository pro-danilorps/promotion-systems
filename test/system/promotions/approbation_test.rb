require 'application_system_test_case'

class Promotion::ApprobationTest < ApplicationSystemTestCase
  def setup
    user = create_user
    @approver = create_another_user
    @promotion = @promotion = Promotion.create!(
      name: 'Natal',
      description: 'Promoção de Natal',
      code: 'NATAL10',
      discount_rate: 10,
      coupon_quantity: 100,
      expiration_date: '22/12/2033',
      user: user
    )
    login_as(user)
  end

  test 'approve a promotion' do
    login_as(@approver)

    visit promotion_path(@promotion)
    accept_confirm { click_on 'Aprovar Promoção' }

    assert_text 'Promoção Natal aprovada com sucesso'
  end

  test 'inabillity to approve your own promotion' do
    visit promotion_path(@promotion)

    assert_no_link 'Aprovar Promoção'
  end

  test 'inabillity to generate coupons on an unapproved promotion' do
    visit promotion_path(@promotion)

    assert_no_link 'Gerar Cupons'
  end
end
