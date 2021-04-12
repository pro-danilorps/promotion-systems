require 'rails_helper'

RSpec.describe "Promotion Model Test" do
  before do
    user = Fabricate(:user)
    @xmas = Fabricate(:promotion, name: 'Natal', description: 'Promoção de Natal',
                      code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                      expiration_date: '22/12/2033')

    @xmassy = Fabricate(:promotion, name: 'Natalina', description: 'Promoção Natalina',
                        code: 'NATALINA15', discount_rate: 15, coupon_quantity: 100,
                        expiration_date: '22/12/2033')

    @cyber = Fabricate(:promotion, name: 'Cyber Monday', description: 'Promoção de Cyber Monday',
                       code: 'CYBER20', discount_rate: 20, coupon_quantity: 200,
                       expiration_date: '22/12/2033')
    login_as(user)
  end

  it 'attributes cannot be blank' do
    promotion = Promotion.new

    expect(promotion.valid?).to_not eq(true)
    expect(promotion.errors[:name]).to include('não pode ficar em branco')
    expect(promotion.errors[:code]).to include('não pode ficar em branco')
    expect(promotion.errors[:discount_rate]).to include('não pode ficar em branco')
    expect(promotion.errors[:coupon_quantity]).to include('não pode ficar em branco')
    expect(promotion.errors[:expiration_date]).to include('não pode ficar em branco')
  end

  it 'code must be uniq' do
    promotion = Promotion.new(code: 'NATAL10', name: 'Natal')

    expect(promotion.valid?).to_not eq(true)
    expect(promotion.errors[:code]).to include('já está em uso')
    expect(promotion.errors[:name]).to include('já está em uso')
  end

  it '.search_exact' do
    result = Promotion.search_exact('Natal')

    expect(result).to include(@xmas)
    expect(result).not_to include(@xmassy)
    expect(result).not_to include(@cyber)
  end

  it '.search_partial' do
    result = Promotion.search_partial('Nat')

    expect(result).to include(@xmas)
    expect(result).to include(@xmassy)
    expect(result).not_to include(@cyber)
  end

  it '.search_exact and .search_partial return nothing' do
    result_exact = Promotion.search_exact('Nat')
    result_partial = Promotion.search_partial('carnaval')

    expect(result_exact).not_to include(@xmas)
    expect(result_exact).not_to include(@xmassy)
    expect(result_exact).not_to include(@cyber)
    expect(result_partial).not_to include(@xmas)
    expect(result_partial).not_to include(@xmassy)
    expect(result_partial).not_to include(@cyber)
  end
end