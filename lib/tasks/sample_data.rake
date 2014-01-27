namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    # Explicit category definitions
    Category.create!(name: "Books",  description: "readable items")
    Category.create!(name: "Movies", description: "watchable items")

    # Repetitive, implicit item definitions
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

    puts "\ndb:populate complete."
  end
end
