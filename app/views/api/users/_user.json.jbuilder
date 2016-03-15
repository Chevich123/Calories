if user.errors.any?
  json.errors user.errors
else
  json.extract! user, :id, :email, :num_of_calories, :created_at, :updated_at, :role
end
