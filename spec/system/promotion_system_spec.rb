require 'rails_helper'

RSpec.describe 'Promotions Management' do
  include ActionMailer::TestHelper
  before do
    driven_by(:selenium_chrome_headless)
    login_as(Fabricate(:user))
  end

  it 'view promotions' do
    Fabricate(:promotion, name: 'Natal',
                          description: 'Promoção de Natal', discount_rate: '10')
    Fabricate(:promotion, name: 'Cyber Monday',
                          description: 'Promoção de Cyber Monday', discount_rate: '15')

    visit root_path
    click_on 'Promoções'

    expect(page).to have_text('Natal')
    expect(page).to have_text('Promoção de Natal')
    expect(page).to have_text('10,00%')
    expect(page).to have_text('Cyber Monday')
    expect(page).to have_text('Promoção de Cyber Monday')
    expect(page).to have_text('15,00%')
  end

  it 'view promotion details' do
    Fabricate(:promotion, name: 'Natal 2021',
                          description: 'Promoção de Natal de 2021', discount_rate: '1',
                          code: 'NATAL21', expiration_date: '26/12/2021', coupon_quantity: '100')

    visit root_path
    click_on 'Promoções'
    click_on 'Natal 2021'

    expect(page).to have_text('Natal 2021')
    expect(page).to have_text('Promoção de Natal de 2021')
    expect(page).to have_text('1,00%')
    expect(page).to have_text('NATAL21')
    expect(page).to have_text('26/12/2021')
    expect(page).to have_text('100')
  end

  it 'no promotion are available' do
    visit root_path
    click_on 'Promoções'

    expect(page).to have_text('Nenhuma promoção cadastrada')
  end

  it 'view promotions and return to home page' do
    visit root_path
    click_on 'Promoções'
    click_on 'Voltar'

    expect(current_path).to eq(root_path)
  end

  it 'view details and return to promotions page' do
    Fabricate(:promotion, name: 'Natal 2021')

    visit root_path
    click_on 'Promoções'
    click_on 'Natal 2021'
    click_on 'Voltar'

    expect(current_path).to eq(promotions_path)
  end

  it 'create promotion' do
    visit root_path
    click_on 'Promoções'
    click_on 'Registrar uma Promoção'
    fill_in 'Nome', with: 'Cyber Monday'
    fill_in 'Descrição', with: 'Promoção de Cyber Monday'
    fill_in 'Código', with: 'CYBER15'
    fill_in 'Desconto', with: '15'
    fill_in 'Quantidade de cupons', with: '90'
    fill_in 'Data de término', with: '22/12/2033'
    click_on 'Criar Promoção'

    expect(current_path).to eq(promotion_path(Promotion.last))
    expect(page).to have_text('Cyber Monday')
    expect(page).to have_text('Promoção de Cyber Monday')
    expect(page).to have_text('15,00%')
    expect(page).to have_text('CYBER15')
    expect(page).to have_text('22/12/2033')
    expect(page).to have_text('90')
    expect(page).to have_link('Voltar')
  end

  it 'create and attributes cannot be blank' do
    visit root_path
    click_on 'Promoções'
    click_on 'Registrar uma Promoção'
    click_on 'Criar Promoção'

    expect(page).to have_text('não pode ficar em branco', count: 5)
  end

  it 'create and code/name must be unique' do
    Fabricate(:promotion, name: 'Natal', code: 'NATAL10')

    visit root_path
    click_on 'Promoções'
    click_on 'Registrar uma Promoção'
    fill_in 'Nome', with: 'Natal'
    fill_in 'Código', with: 'NATAL10'
    click_on 'Criar Promoção'

    expect(page).to have_text('já está em uso', count: 2)
  end

  it 'input blank into edit' do
    promotion = Fabricate(:promotion)

    visit edit_promotion_path(promotion)
    fill_in 'Nome', with: ''
    fill_in 'Descrição', with: ''
    fill_in 'Código', with: ''
    fill_in 'Desconto', with: ''
    fill_in 'Quantidade de cupons', with: ''
    fill_in 'Data de término', with: ''
    click_on 'Confirmar Alterações'

    expect(page).to have_text('não pode ficar em branco', count: 5)
  end

  it 'successfully edit an promotion' do
    Fabricate(:promotion)

    visit edit_promotion_path(Promotion.last)
    fill_in 'Nome', with: 'Cyber Promoção'
    click_on 'Confirmar Alterações'

    expect(page).to have_text('Cyber Promoção')
    expect(page).to have_text('Alterações feitas com sucesso')
  end

  it 'destroy a promotion' do
    promotion = Fabricate(:promotion)

    visit promotion_path(promotion)
    accept_confirm { click_on 'Apagar Promoção' }

    expect(page).to_not have_text('Natal 2029')
    expect(page).to have_text('Promoção apagada com sucesso')
  end

  it 'inability to edit or delete a promotion that has generated coupons' do
    promotion = Fabricate(:promotion)

    visit promotion_path(promotion)
    accept_confirm { click_on 'Aprovar Promoção' }
    click_on 'Gerar Cupons'

    expect(page).to_not have_link('Apagar Promoção')
    expect(page).to_not have_link('Editar Promoção')
  end

  it 'approve a promotion' do
    promotion = Fabricate(:promotion)
    login_as(Fabricate(:user))

    visit promotion_path(promotion)
    assert_emails 1 do
      accept_confirm { click_on 'Aprovar Promoção' }
      expect(page).to have_text("Promoção #{promotion.name} aprovada com sucesso")
    end
  end

  it 'cannot to approve your own promotion' do
    promotion = Fabricate(:promotion)
    login_as(promotion.user)
    visit promotion_path(promotion)

    expect(page).to_not have_link('Aprovar Promoção')
  end

  it 'cannot to generate coupons on an unapproved promotion' do
    promotion = Fabricate(:promotion)
    visit promotion_path(promotion)

    expect(page).to_not have_link 'Gerar Cupons'
  end

  it 'generate promotion coupon codes' do
    promotion = Fabricate(:promotion, code: 'CYBER10')
    approver = Fabricate(:user)
    login_as approver
    approver.promotion_approvals.create!(promotion: promotion)

    visit promotion_path(promotion)
    click_on 'Gerar Cupons'

    expect(page).to have_text('Cupons gerados com sucesso')
    expect(page).to_not have_link('Gerar Cupons')
    expect(page).to have_text('CYBER10-0001')
    expect(page).to have_text('CYBER10-0010')
    expect(page).to have_text('CYBER10-0100')
    expect(page).to_not have_text('CYBER10-1000')
  end

  it 'search promotions by partial terms (and find results)' do
    xmas = Fabricate(:promotion, name: 'Natal')
    xmassy = Fabricate(:promotion, name: 'Natalina')
    cyber = Fabricate(:promotion, name: 'Cyber Monday')

    visit root_path
    click_on 'Promoções'
    fill_in 'Busca', with: 'Natal'
    click_on 'Buscar'

    expect(page).to have_text(xmas.name)
    expect(page).to have_text(xmassy.name)
    expect(page).to_not have_text(cyber.name)
  end

  it 'search promotions by exact terms (and find results)' do
    xmas = Fabricate(:promotion, name: 'Natal')
    xmassy = Fabricate(:promotion, name: 'Natalina')
    cyber = Fabricate(:promotion, name: 'Cyber Monday')

    visit root_path
    click_on 'Promoções'
    fill_in 'Busca', with: 'Natal'
    choose 'Busca Exata'
    click_on 'Buscar'

    expect(page).to have_text(xmas.name)
    expect(page).to_not have_text(xmassy.name)
    expect(page).to_not have_text(cyber.name)
  end

  it 'search blank and return error' do
    visit root_path
    click_on 'Promoções'
    click_on 'Buscar'

    expect(page).to have_text('Nenhuma promoção cadastrada ou encontrada')
  end
end
