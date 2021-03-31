require 'application_system_test_case'

class SearchTest < ApplicationSystemTestCase
  test 'search promotions by partial terms (and find results)' do
    xmas = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
      code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
      expiration_date: '22/12/2033'
    )

    xmassy = Promotion.create!(name: 'Natalina', description: 'Promoção Natalina',
      code: 'NATALINA15', discount_rate: 15, coupon_quantity: 100,
      expiration_date: '22/12/2033'
    )

    cyber = Promotion.create!(name: 'Cyber Monday', description: 'Promoção de Cyber Monday',
      code: 'CYBER20', discount_rate: 20, coupon_quantity: 200,
      expiration_date: '22/12/2033'
    )

    login_user
    visit root_path
    click_on 'Promoções'
    fill_in 'Busca', with: 'Natal'
    click_on 'Buscar'

    assert_text xmas.name
    assert_text xmassy.name
    refute_text cyber.name
  end
end