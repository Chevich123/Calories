Fabricator(:user) do
  email { sequence(:email) { |i| "test#{i}@example.com" } }
  password '123123123'
  password_confirmation '123123123'
  role 'regular'
  num_of_calories 1
end
