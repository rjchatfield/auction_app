class Item < ActiveRecord::Base
  default_scope -> { order('items.created_at DESC') }

  belongs_to :category
  belongs_to :user
  has_many   :bids, dependent: :delete_all

  validates :name,        presence: true, length: 3..50
  validates :starting_price, numericality: true
  validates :category_id, presence: true
  validates :user_id,     presence: true
  validates :close_date,  presence: true

  def self.search(query, category_id)
    if category_id && !category_id.empty?
      items = where('description || name like ? and category_id = ?', "%#{query}%", category_id)
      items
    elsif query && !query.empty?
      items = where('description || name like ?', "%#{query}%")
      items
    else
      find(:all)
    end
  end

  def has_bid?
    Bid.where('item_id = ?', self.id).count > 0
  end

  def closed?
    !close_date.nil? && (Time.now >= close_date)
  end

  def won?
    closed? && has_bid?
  end

  def winner
    won? && Bid.where('item_id = ?', self.id).first.user
  end
end
