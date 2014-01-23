class Item < ActiveRecord::Base
  default_scope -> {order('created_at DESC')};
  belongs_to :category
  validates :name, presence: true, uniqueness: true, length: 3..50
  validates :starting_price, numericality: true
end
