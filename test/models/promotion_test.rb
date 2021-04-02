require "test_helper"

class PromotionTest < ActiveSupport::TestCase
  
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
  
  test 'attributes cannot be blank' do
    promotion = Promotion.new

    refute promotion.valid?
    assert_includes promotion.errors[:name], 'não pode ficar em branco'
    assert_includes promotion.errors[:code], 'não pode ficar em branco'
    assert_includes promotion.errors[:discount_rate], 'não pode ficar em '\
                                                      'branco'
    assert_includes promotion.errors[:coupon_quantity], 'não pode ficar em'\
                                                        ' branco'
    assert_includes promotion.errors[:expiration_date], 'não pode ficar em'\
                                                        ' branco'
  end

  test 'code must be uniq' do
    promotion = Promotion.new(code: 'NATAL10', name: 'Natal')

    refute promotion.valid?
    assert_includes promotion.errors[:code], 'já está em uso'
    assert_includes promotion.errors[:name], 'já está em uso'
  end

  test '.search_exact' do
    result = Promotion.search_exact('Natal')

    assert_includes result, @xmas
    refute_includes result, @cyber
  end

  test '.search_partial' do
  result = Promotion.search_partial('Nat')

  assert_includes result, @xmas
  assert_includes result, @xmassy
  refute_includes result, @cyber
  end

  test '.search_exact and .search_partial return nothing' do
    result_exact = Promotion.search_exact('Nat')
    result_partial = Promotion.search_partial('carnaval')

    refute_includes result_exact, @xmas
    refute_includes result_partial, @xmas
    refute_includes result_partial, @cyber
  end
end
