# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(email: 'admin@example.com', password: '123123123', password_confirmation: '123123123', role: :admin, num_of_calories: 1000)
User.create(email: 'manager@example.com', password: '123123123', password_confirmation: '123123123', role: :manager, num_of_calories: 500)
User.create(email: 'regular@example.com', password: '123123123', password_confirmation: '123123123', role: :regular, num_of_calories: 100)
