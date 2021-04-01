require 'application_system_test_case'

class SearchTest < ApplicationSystemTestCase
  
  def setup
    user = create_user
    @xmas = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
      code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
      expiration_date: '22/12/2033', user: user
    )

    @xmassy = Promotion.create!(name: 'Natalina', description: 'Promoção Natalina',
      code: 'NATALINA15', discount_rate: 15, coupon_quantity: 100,
      expiration_date: '22/12/2033', user: user
    )

    @cyber = Promotion.create!(name: 'Cyber Monday', description: 'Promoção de Cyber Monday',
      code: 'CYBER20', discount_rate: 20, coupon_quantity: 200,
      expiration_date: '22/12/2033', user: user
    )
    login_as(user)
  end
  
  test 'search promotions by partial terms (and find results)' do
    visit root_path
    click_on 'Promoções'
    fill_in 'Busca', with: 'Natal'
    click_on 'Buscar'

    assert_text @xmas.name
    assert_text @xmassy.name
    refute_text @cyber.name
  end

  test 'search promotions by exact terms (and find results)' do
    visit root_path
    click_on 'Promoções'
    fill_in 'Busca', with: 'Natal'
    choose 'Busca Exata'
    click_on 'Buscar'

    assert_text @xmas.name
    refute_text @xmassy.name
    refute_text @cyber.name
  end

  test 'search blank and return error' do
    visit root_path
    click_on 'Promoções'
    click_on 'Buscar'

    assert_text 'Nenhuma promoção cadastrada ou encontrada'
  end

end