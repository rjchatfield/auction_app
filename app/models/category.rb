class Category < ActiveRecord::Base
  has_many :items, dependent: :delete_all
  validates :name, presence: true, uniqueness: true, length: 3..50
end
