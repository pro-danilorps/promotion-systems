require "rails_helper"

RSpec.describe "Promotions management", :type => :system do
  before do
    driven_by(:selenium_chrome_headless)
    @user, @approver = Fabricate.times(2, :user)
    login_as(@user)
    Fabricate.times(9,:promotion, user: @user, approver: @approver)
  end

  it 'view promotions' do
    Fabricate(:promotion, name: 'Natal',
              description: 'Promoção de Natal', discount_rate: '10', user: @user)
    Fabricate(:promotion, name: 'Cyber Monday',
              description: 'Promoção de Cyber Monday', discount_rate: '15', user: @user)

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

  # it 'no promotion are available' do
  #   visit root_path
  #   click_on 'Promoções'

  #   expect(page).to have_text('Nenhuma promoção cadastrada')
  # end

  it 'view promotions and return to home page' do
    visit root_path
    click_on 'Promoções'
    click_on 'Voltar'

    #assert_current_path root_path
    expect(page).to assert_template(root_path)
  end

  it 'view details and return to promotions page' do
    visit root_path
    click_on 'Promoções'
    click_on 'Natal'
    click_on 'Voltar'

    assert_current_path promotions_path
  end

  it 'create promotion' do
    destroy_promotions

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

    assert_current_path promotion_path(Promotion.last)
    expect(page).to have_text('Cyber Monday')
    expect(page).to have_text('Promoção de Cyber Monday')
    expect(page).to have_text('15,00%')
    expect(page).to have_text('CYBER15')
    expect(page).to have_text('22/12/2033')
    expect(page).to have_text('90')
    assert_link 'Voltar'
  end

  it 'create and attributes cannot be blank' do
    visit root_path
    click_on 'Promoções'
    click_on 'Registrar uma Promoção'
    click_on 'Criar Promoção'

    expect(page).to have_text('não pode ficar em branco', count: 5)
  end

  it 'create and code/name must be unique' do
    visit root_path
    click_on 'Promoções'
    click_on 'Registrar uma Promoção'
    fill_in 'Nome', with: 'Natal'
    fill_in 'Código', with: 'NATAL10'
    click_on 'Criar Promoção'

    expect(page).to have_text('já está em uso', count: 2)
  end

  it 'input blank into edit' do
    visit edit_promotion_path(@promotion)
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
    visit edit_promotion_path(@promotion)
    fill_in 'Nome', with: 'Natal de 2021'
    click_on 'Confirmar Alterações'

    expect(page).to have_text('Natal de 2021')
    expect(page).to have_text('Alterações feitas com sucesso')
  end

  it 'destroy a promotion' do
    visit promotion_path(@promotion)
    accept_confirm { click_on 'Apagar Promoção' }

    assert_no_text 'Natal'
    expect(page).to have_text('Promoção apagada com sucesso')
  end

  it 'inability to edit or delete a promotion that has generated coupons' do
    user = create_another_user
    login_as(user)

    visit promotion_path(@promotion)
    accept_confirm { click_on 'Aprovar Promoção' }
    click_on 'Gerar Cupons'

    assert_no_link 'Apagar Promoção'
    assert_no_link 'Editar Promoção'
  end
end