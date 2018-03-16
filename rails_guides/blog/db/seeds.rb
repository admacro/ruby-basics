# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# run `rails db:seed` to execute the follow code to load data into your database
# Note that, this can be run multiple time. Usually, you don't run it separately
# as it will be run when you run `rails db:`
5.times do |i|
  User.create(name: "User ##{i}", age: 25, occupation: "Developer")
end
