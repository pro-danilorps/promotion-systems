require 'application_system_test_case'

class GenerateCouponsTest < ApplicationSystemTestCase
  test 'generate promotion coupon codes' do
    promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
      code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
      expiration_date: '22/12/2033'
    )
    
    login_user
    visit promotion_path(promotion)
    click_on 'Gerar Cupons'

    assert_text 'Cupons gerados com sucesso!'
    assert_no_link 'Gerar Cupons'
    assert_text 'NATAL10-0001'
    assert_text 'NATAL10-0010'
    assert_text 'NATAL10-0100'
    assert_no_text 'NATAL10-1000'
  end
end