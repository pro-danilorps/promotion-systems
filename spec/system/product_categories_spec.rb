require "rails_helper"

RSpec.describe 'Product Categories Test' do
  before do
    driven_by(:selenium_chrome_headless)
    login_as(Fabricate(:user))
    
    @product_category = ProductCategory.create!(
      name: 'Produto Anti-Fraude',
      code: 'ANTIFRA'
    )
    ProductCategory.create!(
      name: 'Produto Pro-Fraude',
      code: 'PROFRA'
    )
  end

  it 'create product categories and show them' do
    visit root_path
    click_on 'Categorias de Produto'

    expect(page).to have_text('Produto Anti-Fraude')
    expect(page).to have_text('ANTIFRA')
    expect(page).to have_text('Produto Pro-Fraude')
    expect(page).to have_text('PROFRA')
  end

  it 'edit and leave blank fields to return errors' do
    visit edit_product_category_path(@product_category)
    fill_in 'Nome', with: ''
    fill_in 'Código', with: ''
    click_on 'Confirmar Alterações'

    expect(page).to have_text('não pode ficar em branco', count: 2)
  end

  it 'edit and its a success' do
    visit edit_product_category_path(@product_category)
    fill_in 'Nome', with: 'Produto Neutro-Fraude'
    fill_in 'Código', with: 'NEUFRA'
    click_on 'Confirmar Alterações'

    expect(page).to have_text('Alterações feitas com sucesso!')
  end

  it 'destroy product category' do
    visit root_path
    click_on 'Categorias de Produto'
    click_on 'Produto Anti-Fraude'

    accept_confirm do
      click_on 'Apagar Categoria de Produto'
    end
    
    expect(page).to have_text('Categoria apagada com sucesso!')
  end
end
