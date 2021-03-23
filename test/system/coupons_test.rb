require 'application_system_test_case'

class CouponsTest < ApplicationSystemTestCase
  
  test 'disable a coupon' do
    promotion = Promotion.create!(
      name: 'Natal',
      description: 'Promoção de Natal',
      code: 'NATAL10',
      discount_rate: 10,
      coupon_quantity: 3,
      expiration_date: '22/12/2033'
    )
    promotion.generate_coupons!

    visit promotion_path(promotion)
    within 'tr#coupon-natal10-0002' do
      click_on 'Desabilitar'
    end
    
    assert_text "Cupom NATAL10-0002 desabilitado com sucesso!"
    within 'tr#coupon-natal10-0002' do
      assert_text "Desabilitado"
      assert_no_link "Desabilitar"
    end 
  end

  test 're-enable a coupon' do 
    promotion = Promotion.create!(
      name: 'Natal',
      description: 'Promoção de Natal',
      code: 'NATAL10',
      discount_rate: 10,
      coupon_quantity: 3,
      expiration_date: '22/12/2033'
    )
    promotion.generate_coupons!

    visit promotion_path(promotion)
    within 'tr#coupon-natal10-0002' do
      click_on 'Desabilitar'
    end
    within 'tr#coupon-natal10-0002' do
      click_on 'Ativar'
    end

    assert_text "Cupom NATAL10-0002 ativado com sucesso!"
    within 'tr#coupon-natal10-0002' do
      assert_text "Ativo"
      assert_no_link "Ativar"
    end 

  end


end