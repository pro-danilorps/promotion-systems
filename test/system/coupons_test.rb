require 'application_system_test_case'

class CouponsTest < ApplicationSystemTestCase
  def setup
    @user = create_user
    @approver = create_another_user
    @promotion = Promotion.create!(
      name: 'Natal',
      description: 'Promoção de Natal',
      code: 'NATAL10',
      discount_rate: 10,
      coupon_quantity: 3,
      expiration_date: '22/12/2033',
      user: @user
    )
    login_as @user
    @approver.promotion_approvals.create!(user: @approver, promotion: @promotion)
  end

  test 'disable a coupon' do
    @promotion.generate_coupons!

    visit promotion_path(@promotion)
    within 'tr#coupon-natal10-0002' do
      click_on 'Desabilitar'
    end

    assert_text 'Cupom NATAL10-0002 desabilitado com sucesso!'
    within 'tr#coupon-natal10-0002' do
      assert_text 'Desabilitado'
      assert_no_link 'Desabilitar'
    end
  end

  test 're-enable a coupon' do
    @promotion.generate_coupons!

    visit promotion_path(@promotion)
    within 'tr#coupon-natal10-0002' do
      click_on 'Desabilitar'
    end
    within 'tr#coupon-natal10-0002' do
      click_on 'Ativar'
    end

    assert_text 'Cupom NATAL10-0002 ativado com sucesso!'
    within 'tr#coupon-natal10-0002' do
      assert_text 'Ativo'
      assert_no_link 'Ativar'
    end
  end
end
