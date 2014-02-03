class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :show, :edit, :update, :destroy]
  before_action :set_user,       only: [        :show, :edit, :update, :destroy]
  before_action :correct_user,   only: [               :edit, :update, :destroy]

  def index
    @users = User.paginate(page: params[:page], per_page: 10).all
  end

  def show
    @items_sell_page = :page_sell
    @items_sell = Item.paginate(page: params[@items_sell_page], per_page: 5)
                      .where('items.close_date >= ?', Time.now)
                      .where('User_id = ?', @user.id)
    @items_sold_page = :page_sold
    @items_sold = Item.paginate(page: params[@items_sold_page], per_page: 5)
                      .joins('JOIN bids ON bids.item_id = items.id')
                      .where('items.user_id = ?', @user.id)
                      .where('items.close_date < ?', Time.now)
                      .group(:item_id)
    @items_bid_page = :page_bid
    @items_bid  = Item.paginate(page: params[@items_bid_page], per_page: 5)
                      .joins('JOIN bids ON bids.item_id = items.id')
                      .where(bids: { user_id: @user.id })
                      .where('items.close_date >= ?', Time.now)
                      .group(:item_id)
    @items_won_page = :page_won
    @items_won  = Item.paginate(page: params[@items_won_page], per_page: 5)
                      .joins('JOIN bids ON bids.item_id = items.id')
                      .where(bids: { user_id: @user.id })
                      .where('items.close_date < ?', Time.now)
                      .group(:item_id)
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, success: "Welcome to Auction App, #{@user.first_name}." }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update_attributes(user_params)
        format.html { redirect_to @user, success: 'Account details were successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html {
        flash[:success] = 'User deleted.'
        redirect_to users_url
      }
      format.json { head :no_content }
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: 'Please sign in.'
    end
  end

  def correct_user
    unless signed_in? && (current_user?(@user) || current_user.admin?)
      redirect_to current_user, alert: "You can't do that to #{@user.first_name}'s account!? Here's your own."
    end
  end
end
