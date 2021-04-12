require 'rails_helper'

RSpec.describe 'Authentication Test' do
  before do
    driven_by(:selenium_chrome_headless)
  end

  it 'user sign up' do
    visit root_path
    click_on 'Cadastrar'
    fill_in 'Nome', with: 'Jane Doe'
    fill_in 'Email', with: 'jane.doe@iugu.com.br'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme a nova senha', with: 'password'
    within 'form' do
      click_on 'Confirmar Cadastro'
    end

    expect(page).to have_text('Jane Doe')
    expect(page).to have_link('Sair')
    expect(page).to_not have_link('Cadastrar')
    expect(current_path).to eq(root_path)
  end

  it 'user sign in' do
    user = Fabricate(:user, email: 'fulano@iugu.com.br', password: '123456')

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'fulano@iugu.com.br'
    fill_in 'Senha', with: '123456'
    within 'form' do
      click_on 'Entrar'
    end

    expect(page).to have_text(user.name)
    expect(current_path).to eq(root_path)
    expect(page).to have_link('Sair')
    expect(page).to_not have_link('Entrar')
  end
  # TODO: Expandir o Teste de Autenticação
end
