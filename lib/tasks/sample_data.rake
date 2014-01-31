namespace :db do
  desc 'Fill database with sample data'
  task populate: :environment do
    # Category
    Category.create!(name: 'Books',  description: 'readable items')
    Category.create!(name: 'Movies', description: 'watchable items')
    puts 'db:populate Categories Created.'

    # Item
    99.times do |n|
      name           = "#{Faker::Commerce.product_name} - #{n}"
      description    = "#{Faker::Company.catch_phrase}, with #{Faker::Company.catch_phrase}"
      user_id        = (n % 4) + 1
      category_id    = (n % 2) + 1
      starting_price = Faker::Number.number(9).to_f - 0.05
      Item.create!(name: name,
                   description: description,
                   category_id: category_id,
                   user_id: user_id,
                   starting_price: starting_price)
    end
    puts 'db:populate Items Created.'

    # Users
    User.create!(first_name: 'Smiley',
                  last_name: 'Rob',
                      email: 'robert.chatfield@griffithuni.edu.au',
                   password: 'asdasd',
                   password_confirmation: 'asdasd',
                      admin: true)
    User.create!(first_name: 'Rodney',
                  last_name: 'Topor',
                      email: 'r.topor@gu.edu.au',
                   password: 'asdasd',
                   password_confirmation: 'asdasd')

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
    puts 'db:populate Users Created.'

    puts 'db:populate Complete.'
  end
end
