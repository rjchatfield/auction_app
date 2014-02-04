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

  # Paperclip
  has_attached_file :avatar,
                    styles: { :medium => "300x300>", :thumb => "50x50>" },
                    default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  validates_attachment_size :avatar, less_than: 3.megabytes

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

  def self.that_user_won(user)
    result = []
    self.that_user_bid_on(user).each { |item| result.push(item) if item.bids.first.user_id == user.id }
    result
  end

  def self.that_user_bid_on(user)
    joins('JOIN bids ON bids.item_id = items.id').where(bids: { user_id: user.id }).where('items.close_date < ?', Time.now).all
  end
end
