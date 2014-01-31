module BidsHelper
  def min_bid_value_for(item)
    (highest_bid_for(item.id) || item.starting_price) + stepper_value
  end

  def highest_bid_for(item_id)
    bids = Bid.where('item_id = ?', item_id)
    bids.maximum('amount') unless bids.nil?
  end

  def stepper_value
    0.01
  end
end
