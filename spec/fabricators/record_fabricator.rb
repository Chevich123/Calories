Fabricator(:record) do
  user { User.first || Fabricate(:user) }
  date Date.current
  time Time.current.seconds_since_midnight
  meal 'Banana'
  num_of_calories 1
end
