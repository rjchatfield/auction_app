class Category < ActiveRecord::Base
  has_many :items
  validates :name, presence: true, uniqueness: true, length: 3..50
end
