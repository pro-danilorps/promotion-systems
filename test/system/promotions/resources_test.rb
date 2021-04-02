require 'application_system_test_case'

class ResourcesTest < ApplicationSystemTestCase
  
  def setup
    user = create_user
    @promotion = Promotion.create!(
      name: 'Natal',
      description: 'Promoção de Natal',
      code: 'NATAL10',
      discount_rate: 10,
      coupon_quantity: 100,
      expiration_date: '22/12/2033',
      user: user
    )
    Promotion.create!(
      name: 'Cyber Monday',
      coupon_quantity: 90,
      description: 'Promoção de Cyber Monday',
      code: 'CYBER15',
      discount_rate: 15,
      expiration_date: '22/12/2033',
      user: user
    )
    login_as(user)
  end

  def destroy_promotions
    promotions = Promotion.all
    promotions.each do |promotion|
      Promotion.destroy(promotion.id)
    end
  end

  test 'view promotions' do
    visit root_path
    click_on 'Promoções'

    assert_text 'Natal'
    assert_text 'Promoção de Natal'
    assert_text '10,00%'
    assert_text 'Cyber Monday'
    assert_text 'Promoção de Cyber Monday'
    assert_text '15,00%'
  end

  test 'view promotion details' do
    visit root_path
    click_on 'Promoções'
    click_on 'Cyber Monday'

    assert_text 'Cyber Monday'
    assert_text 'Promoção de Cyber Monday'
    assert_text '15,00%'
    assert_text 'CYBER15'
    assert_text '22/12/2033'
    assert_text '90'
  end

  test 'no promotion are available' do
    destroy_promotions

    visit root_path
    click_on 'Promoções'

    assert_text 'Nenhuma promoção cadastrada'
  end

  test 'view promotions and return to home page' do
    visit root_path
    click_on 'Promoções'
    click_on 'Voltar'

    assert_current_path root_path
  end

  test 'view details and return to promotions page' do
    visit root_path
    click_on 'Promoções'
    click_on 'Natal'
    click_on 'Voltar'

    assert_current_path promotions_path
  end

  test 'create promotion' do
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
    assert_text 'Cyber Monday'
    assert_text 'Promoção de Cyber Monday'
    assert_text '15,00%'
    assert_text 'CYBER15'
    assert_text '22/12/2033'
    assert_text '90'
    assert_link 'Voltar'
  end

  test 'create and attributes cannot be blank' do
    visit root_path
    click_on 'Promoções'
    click_on 'Registrar uma Promoção'
    click_on 'Criar Promoção'

    assert_text 'não pode ficar em branco', count: 5
  end

  test 'create and code/name must be unique' do
    visit root_path
    click_on 'Promoções'
    click_on 'Registrar uma Promoção'
    fill_in 'Nome', with: 'Natal'
    fill_in 'Código', with: 'NATAL10'
    click_on 'Criar Promoção'
    
    assert_text 'já está em uso', count: 2
  end

  test 'input blank into edit' do
    visit edit_promotion_path(@promotion)
    fill_in 'Nome', with: ''
    fill_in 'Descrição', with: ''
    fill_in 'Código', with: ''
    fill_in 'Desconto', with: ''
    fill_in 'Quantidade de cupons', with: ''
    fill_in 'Data de término', with: ''
    click_on 'Confirmar Alterações'

    assert_text 'não pode ficar em branco', count: 5
  end

  test 'successfully edit an promotion' do
    visit edit_promotion_path(@promotion)
    fill_in 'Nome', with: 'Natal de 2021'
    click_on 'Confirmar Alterações'

    assert_text 'Natal de 2021'
    assert_text 'Alterações feitas com sucesso'
  end
  
  test 'destroy a promotion' do
    visit promotion_path(@promotion)
    accept_confirm { click_on 'Apagar Promoção' }

    assert_no_text 'Natal'
    assert_text 'Promoção apagada com sucesso'
  end

  test 'inability to edit or delete a promotion that has generated coupons' do
    user = create_another_user
    login_as(user)

    visit promotion_path(@promotion)
    accept_confirm { click_on 'Aprovar Promoção' }
    click_on 'Gerar Cupons'

    assert_no_link 'Apagar Promoção'
    assert_no_link 'Editar Promoção'
  end

end