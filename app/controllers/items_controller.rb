class ItemsController < ApplicationController
  before_action :signed_in_user,    only: [               :new, :edit, :create, :update, :destroy]
  before_action :set_item,          only: [        :show,       :edit,          :update, :destroy]
  before_action :categories_array,  only: [:index,        :new, :edit, :create, :updated         ]
  before_action :correct_user,      only: [                     :edit,          :updated         ]
  before_action :correct_user_admin,only: [                                              :destroy]

  # GET /items
  # GET /items.json
  def index
    @items_page = :page
    @items = Item.paginate(page: params[@items_page], per_page: 10)
                 .where('items.close_date >= ?', Time.now)
                 .search(params[:query], params[:category_id])
    #
  end

  # GET /items/1
  # GET /items/1.json
  def show
    @bid  = Bid.new
    @bids = Bid.paginate(page: params[:page], per_page: 5)
               .where('item_id = ?', @item.id)
  end

  # GET /items/new
  def new
    @item = Item.new
    @item.close_date = Time.now + 1.day
  end

  # GET /items/1/edit
  def edit
    if @item.closed?
      redirect_to @item, notice: 'You can\'t edit this now. Bidding has ended.'
    elsif @item.has_bid?
      redirect_to @item, notice: 'You can\'t edit this now. Bidding has begun.'
    end
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params)
    if @item.close_date <= Time.now
      @item.errors.add(:close_date, 'must close after today')
      render action: 'new'
    else
      respond_to do |format|
        if @item.save
          format.html { redirect_to @item, notice: 'Item was successfully created.' }
          format.json { render action: 'show', status: :created, location: @item }
        else
          format.html { render action: 'new' }
          format.json { render json: @item.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    if @item.has_bid?
      redirect_to @item, notice: 'You can\'t edit this now. Bidding has begun.'
    else
      respond_to do |format|
        if @item.update(item_params)
          format.html { redirect_to @item, notice: 'Item was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @item.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_item
    @item = Item.find(params[:id])
  end

  #
  def categories_array
    @categories = Category.all.map { |c| [c.name, c.id] }
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def item_params
    params.require(:item).permit(:name, :description, :user_id, :starting_price, :category_id, :close_date, :avatar)
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: 'Please sign in.'
    end
  end

  def correct_user
    unless signed_in? && current_user?(@item.user)
      redirect_to items_url, alert: "You can't do that!?."
    end
  end

  def correct_user_admin
    unless signed_in? && (current_user?(@item.user) || current_user.admin?)
      redirect_to items_url, alert: "You can't do that!?."
    end
  end
end
