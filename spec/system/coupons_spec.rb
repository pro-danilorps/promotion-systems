require "rails_helper"

RSpec.describe 'Coupons Test' do
  before do
    driven_by(:selenium_chrome_headless)

    @promotion = Fabricate(:promotion)
    user = @promotion.user
    approver = Fabricate(:user)
    approver.promotion_approvals.create!(user: approver, promotion: @promotion)
    login_as(user)
  end

  it 'disable a coupon' do
    @promotion.generate_coupons!
    coupon = @promotion.coupons.first

    visit promotion_path(@promotion)
    within "tr#coupon-#{coupon.code.downcase}" do
      click_on 'Desabilitar'
    end

    expect(page).to have_text("Cupom #{coupon.code} desabilitado com sucesso!")
    within "tr#coupon-#{coupon.code.downcase}" do
      expect(page).to have_text('Desabilitado')
      expect(page).to_not have_link('Desabilitar')
    end
  end

  it 're-enable a coupon' do
    @promotion.generate_coupons!
    coupon = @promotion.coupons.first

    visit promotion_path(@promotion)
    within "tr#coupon-#{coupon.code.downcase}" do
      click_on 'Desabilitar'
    end
    within "tr#coupon-#{coupon.code.downcase}" do
      click_on 'Ativar'
    end

    expect(page).to have_text("Cupom #{coupon.code} ativado com sucesso!")
    within "tr#coupon-#{coupon.code.downcase}" do
      expect(page).to have_text('Ativo')
      expect(page).to_not have_link('Ativar')
    end
  end
end
