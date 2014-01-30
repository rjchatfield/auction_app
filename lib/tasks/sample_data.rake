namespace :db do
  desc 'Fill database with sample data'
  task populate: :environment do
    # Category
    Category.create!(name: 'Books',  description: 'readable items')
    Category.create!(name: 'Movies', description: 'watchable items')
    puts '\n -- db:populate Categories Created.'

    # Item
    puts '\n -- db:populate Items Created.'
    99.times do |n|
      name           = "#{Faker::Commerce.product_name} - #{n}"
      description    = "#{Faker::Company.catch_phrase}, with #{Faker::Company.catch_phrase}"
      vendor         = Faker::Company.name
      category_id    = (n % 2) + 1
      starting_price = Faker::Number.number(9).to_f - 0.05
      Item.create!(name: name,
                   description: description,
                   vendor: vendor,
                   category_id: category_id,
                   starting_price: starting_price)
    end

    # Users
    puts '\n -- db:populate Users Created.'
    2.times do |u|
      first = Faker::Name.first_name
      last  = Faker::Name.last_name
      email = "#{u}#{Faker::Internet.email}"
      passw = 'rodney'
      User.create!(first_name: first,
                   last_name: last,
                   email: email,
                   password: passw,
                   password_confirmation: passw)
    end

    puts '\ndb:populate complete.'
  end
end
