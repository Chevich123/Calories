if record.errors.any?
  json.errors record.errors
else
  json.extract! record, :id, :meal, :num_of_calories, :created_at, :updated_at, :user_id, :date, :time
  json.user do
    json.extract! record.user, :id, :email, :num_of_calories
  end
end
