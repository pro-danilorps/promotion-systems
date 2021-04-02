require 'application_system_test_case'

class ProductCategoriesTest < ApplicationSystemTestCase

  def setup
    @user = create_user
    @product_category = ProductCategory.create!(
                          name: 'Produto Anti-Fraude',
                          code: 'ANTIFRA'
                        )
    ProductCategory.create!(
      name: 'Produto Pro-Fraude', 
      code: 'PROFRA'
    )
    login_as @user
  end

  test 'create product categories and show them' do
    visit root_path
    click_on 'Categorias de Produto'

    assert_text 'Produto Anti-Fraude'
    assert_text 'ANTIFRA'
    assert_text 'Produto Pro-Fraude'
    assert_text 'PROFRA'
  end

  test 'edit and leave blank fields to return errors' do
    visit edit_product_category_path(@product_category)
    fill_in 'Nome', with: ''
    fill_in 'Código', with: ''
    click_on 'Confirmar Alterações'

    assert_text 'não pode ficar em branco', count: 2
  end

  test 'edit and its a success' do
    visit edit_product_category_path(@product_category)
    fill_in 'Nome', with: 'Produto Neutro-Fraude'
    fill_in 'Código', with: 'NEUFRA'
    click_on 'Confirmar Alterações'

    assert_text 'Alterações feitas com sucesso!'
  end

  test 'destroy product category' do
    visit root_path
    click_on 'Categorias de Produto'
    click_on 'Produto Anti-Fraude'
    
    accept_confirm do
      click_on 'Apagar Categoria de Produto'
    end
    assert_text 'Categoria apagada com sucesso!'
  end
end