require 'application_system_test_case'

class AuthenticationTest < ApplicationSystemTestCase
  test 'user sign up' do
    visit root_path
    click_on 'Cadastrar'
    fill_in 'Nome', with: 'Jane Doe'
    fill_in 'Email', with: 'jane.doe@iugu.com.br'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme a nova senha', with: 'password'
    within 'form' do
      click_on 'Confirmar Cadastro'
    end

    assert_text 'Jane Doe'
    assert_link 'Sair'
    assert_no_link 'Cadastrar'
    assert_current_path root_path
  end

  test 'user sign in' do
    user = create_user

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'fulano@iugu.com.br'
    fill_in 'Senha', with: '123456'
    within 'form' do
      click_on 'Entrar'
    end

    assert_text user.name
    assert_current_path root_path
    assert_link 'Sair'
    assert_no_link 'Entrar'
  end
end