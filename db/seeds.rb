# The create! method is just like the create method, except it raises an
# exception for an invalid user rather than returning false.
# This behavior makes debugging easier by avoiding silent errors.
User.create!(first_name:  "Dom",
             last_name: "Michalec",
             email: "dominicjjmichalec@gmail.com",
             password:              "foobar",
             password_confirmation: "foobar",
             activated: true,
             activated_at: Time.zone.now)

199.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(first_name:  name,
               last_name: name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

users = User.order(:created_at).take(200)
50.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.microposts.create!(content: content) }
end

# to reset the database run rails db:migrate:reset
# to seed the database run rails db:seed
