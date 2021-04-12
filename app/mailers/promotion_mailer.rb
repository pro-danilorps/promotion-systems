class PromotionMailer < ApplicationMailer
  def approval_email(...)
    @promotion = params[:promotion]
    @user = params[:user]
    mail to:'dan@ric.com', subject: "Sua promoção \"#{@promotion}\" foi aprovada!"
  end
end