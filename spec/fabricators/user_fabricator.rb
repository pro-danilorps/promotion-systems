Fabricator(:user) do
  name { sequence(:name) { |i| "Fulano#{i}" } }
  email { sequence(:email) { |i| "fulano#{i}@iugu.com.br" } }
  password '123456'
end
