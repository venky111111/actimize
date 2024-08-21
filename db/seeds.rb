# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# AdminUser.create!(email: 'studioAdmin@gmail.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
UserApp.create(
  name: "My New App",
  logo: "path/to/logo.png",
  theme_color: "#ff5733",
  app_platform: ["iOS", "Android"],
  design: true,
  basic_build: false,
  full_build: true,
  note: "This is a note about the app.",
  budget: "10000",
  payment_way: "credit_card",
  support: true,
  cloud: false,
  market_place: true,
  user_id: 1
)
