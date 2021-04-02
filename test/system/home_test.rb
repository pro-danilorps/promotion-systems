require 'application_system_test_case'

class HomeTest < ApplicationSystemTestCase
  test 'visiting the index' do
    login_as create_user
    
    visit root_path

    assert_selector 'h3', text: 'Boas vindas ao sistema de gestão de promoções'
  end
end