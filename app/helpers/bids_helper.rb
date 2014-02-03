module BidsHelper
  def min_bid_value_for(item)
    if has_bid?(item)
      highest_bid_for(item.id) + stepper_value
    else
      item.starting_price
    end
  end

  def highest_bid_for(item_id)
    bids = Bid.where('item_id = ?', item_id)
    bids.maximum('amount') unless bids.nil?
  end

  def has_bid?(item)
    !highest_bid_for(item.id).nil?
  end

  def stepper_value
    1
  end
end
