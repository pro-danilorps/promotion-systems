require 'application_system_test_case'

class ProductCategoriesTest < ApplicationSystemTestCase

  test 'create product categories and show them' do
    ProductCategory.create!(name: 'Produto Anti-Fraude', code: 'ANTIFRA')
    ProductCategory.create!(name: 'Produto Pro-Fraude', code: 'PROFRA')

    login_user
    visit root_path
    click_on 'Categorias de Produto'

    assert_text 'Produto Anti-Fraude'
    assert_text 'ANTIFRA'
    assert_text 'Produto Pro-Fraude'
    assert_text 'PROFRA'
  end

  test 'edit and leave blank fields to return errors' do
    product_category = ProductCategory.create!(name: 'Produto Anti-Fraude', code: 'ANTIFRA')

    login_user
    visit edit_product_category_path(product_category)
    fill_in 'Nome', with: ''
    fill_in 'Código', with: ''
    click_on 'Confirmar Alterações'

    assert_text 'Não pode ficar em branco', count: 2
  end

  test 'edit and its a success' do
    product_category = ProductCategory.create!(name: 'Produto Anti-Fraude', code: 'ANTIFRA')

    login_user
    visit edit_product_category_path(product_category)
    fill_in 'Nome', with: 'Produto Pro-Fraude'
    fill_in 'Código', with: 'PROFRA'
    click_on 'Confirmar Alterações'

    assert_text 'Alterações feitas com sucesso!'
  end

  test 'destroy product category' do
    ProductCategory.create!(name: 'Produto Anti-Fraude', code: 'ANTIFRA')
    
    login_user
    visit root_path
    click_on 'Categorias de Produto'
    click_on 'Produto Anti-Fraude'
    accept_confirm do
      click_on 'Apagar Categoria de Produto'
    end

    assert_text 'Categoria apagada com sucesso!'
  end

end