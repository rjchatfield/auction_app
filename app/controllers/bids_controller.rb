class BidsController < ApplicationController
  before_action :signed_in_user,    only: [:create, :destroy]
  before_action :set_bid,           only: [         :destroy]
  before_action :correct_user_admin,only: [         :destroy]

  def create
    @bid = Bid.new(bid_params)
    :correct_user
    if valid? && @bid.save
      redirect_to @bid.item, notice: 'You are the highest bidder.'
    else
      flash[:alert] = 'Invalid bid.'
      redirect_to @bid.item
    end
  end

  def destroy
    @bid.destroy
    respond_to do |format|
      format.html { redirect_to @bid.item }
      format.json { head :no_content }
    end
  end

  private

  def set_bid
    @bid = Bid.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def bid_params
    params.require(:bid).permit(:amount, :item_id, :user_id)
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: 'Please sign in.'
    end
  end

  def correct_user
    if current_user?(@bid.user)
      redirect_to items_url, alert: "You can't do that!?."
    end
  end

  def correct_user_admin
    if current_user?(@bid.user) && !current_user.admin?
      redirect_to items_url, alert: "You can't do that!?."
    end
  end

  def valid?
    !@bid.item.closed? && !@bid.amount.nil? && @bid.amount >= min_bid_value_for(@bid.item)
  end
end
