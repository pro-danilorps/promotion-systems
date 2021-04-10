Fabricator(:promotion) do
  name { sequence(:name) { |i| "Natal #{i+1}0" }}
  description { sequence(:description) { |i| "Promoção de Natal" }}
  code { sequence(:code) { |i| "NATAL#{i+1}0" }}
  discount_rate 25
  coupon_quantity 100
  expiration_date "26/12/2021"
  user
end