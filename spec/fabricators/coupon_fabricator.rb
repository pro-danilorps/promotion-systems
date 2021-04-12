Fabricator(:coupon) do
  code { sequence(:code) { |i| "NATAL10-#{format('%04d', (i + 1))}" } }
  promotion
end
