class Bid < ActiveRecord::Base
  default_scope -> { order('bids.created_at DESC') }

  belongs_to :item
  belongs_to :user

  validates :amount,  presence: true, numericality: true
  validates :item_id, presence: true
  validates :user_id, presence: true
end
