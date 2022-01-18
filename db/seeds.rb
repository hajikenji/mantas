# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
10.times do |n|
  name = Faker::Games::SuperSmashBros.fighter
  email = Faker::Internet.email
  password = "dddd"
  User.create!(
               name: name,
               email: email,
               password: password
  )
end

10.times do |n|
  name = Faker::Games::SuperSmashBros.fighter
  Label.create!(
               label_name: name
  )
end



10.times do |n|
  a = User.all.size
  user = User.all[rand(0..a)]

  name = Faker::Games::SuperSmashBros.fighter
  content = "aaa"
  time = Faker::Time.between(from: DateTime.now - 1, to: DateTime.now)
  status = rand(1..3)
  priority = status + 3
  label_ids = rand(Label.first[:id]..Label.first[:id] + Label.all.size)
  Task.create!(
               name: name,
               content: content,
               time: time,
               status: status,
               priority: priority,
               label_ids: label_ids,
               user_id: user.id
  )
end