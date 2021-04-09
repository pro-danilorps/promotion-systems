Fabricator(:promotion) do
  name { sequence(:name) { |i| "Natal 202#{i+1}" }}
  description { sequence(:description) { |i| "Promoção de Natal de 202#{i+1}" }}
  code { sequence(:code) { |i| "NATAL2#{i+1}" }}
  discount_rate { sequence(:discount_rate) { |i| "#{(i+1)*(i+1)}".to_i }}
  coupon_quantity '100'
  expiration_date { sequence(:expiration_date) { |i| "26/12/202#{i+1}" }}
end