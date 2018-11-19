15.times do
  User.create(
    email: Faker::Internet.unique.email,
    username: Faker::Internet.unique.user_name,
    password: 'password',
    catchphrase: "ODAAT",
    bio: "I HATE EVERYTHING AND I SUCK",
    years_sober: 5
  )
end
