namespace :db do
  desc 'Fill database with sample data'
  task populate: :environment do
    # Category
    Category.create!(name: 'Books',     description: 'Readable items')
    Category.create!(name: 'Movies',    description: 'Watchable items')
    Category.create!(name: 'Software',  description: 'Usable items')
    puts 'db:populate Created Categories.'

    # Users
    User.create!(first_name: 'Robert',
                  last_name: 'Chatfield',
                      email: 'robert.chatfield@griffithuni.edu.au',
                   password: 'password',
                   password_confirmation: 'password',
                      admin: true)
    User.create!(first_name: 'Rodney',
                  last_name: 'Topor',
                      email: 'r.topor@gu.edu.au',
                   password: 'password',
                   password_confirmation: 'password')

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
    puts 'db:populate Created Users.'

    # Item
    2.times do |u|
      user_id = u + 1
      4.times do |n|
        name           = "#{Faker::Commerce.product_name}"
        description    = "#{Faker::Company.catch_phrase}, with #{Faker::Company.catch_phrase}"
        category_id    = (n % 3) + 1
        starting_price = Faker::Number.number(2).to_f - 0.05
        close_date     = Time.now + (n%2 * 13 - 3).days
        Item.create!(name: name,
                     description: description,
                     category_id: category_id,
                     user_id: user_id,
                     starting_price: starting_price,
                     close_date: close_date)
      end
    end
    puts 'db:populate Created Items.'

    Bid.create!( amount: 30000.00,
                item_id: 5,
                user_id: 4)
    Bid.create!( amount: 40000.00,
                item_id: 6,
                user_id: 3)
    Bid.create!( amount: 50000.00,
                item_id: 3,
                user_id: 4)
    Bid.create!( amount: 60000.00,
                item_id: 4,
                user_id: 3)
    puts 'db:populate Created Bids.'

    puts 'db:populate Complete.'
  end
end
