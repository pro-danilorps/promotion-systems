require "rails_helper"

RSpec.describe 'Home Test' do
  before do
    driven_by(:selenium_chrome_headless)
  end
  
  it 'visiting the index' do
    user = Fabricate(:user)
    login_as(user)

    visit root_path

    assert_selector 'h3', text: 'Boas vindas ao sistema de gestão de promoções'
  end
end
