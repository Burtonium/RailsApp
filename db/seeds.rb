# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#

User.create!(name:  "Matt Burton",
             email: "example@railstutorial.org",
             language:              "klingon",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true, 
             activated: true,
             activated_at: Time.zone.now)
             
99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  language = Faker::Beer.name
  User.create!(name:  name,
               email: email,
               language: language,
               password:              password,
               password_confirmation: password, 
               activated: true,
               activated_at: Time.zone.now)
end