class ItemsController < ApplicationController
  before_action :signed_in_user,   only: [               :new, :edit, :create, :update, :destroy]
  before_action :set_item,         only: [        :show,       :edit,          :update, :destroy]
  before_action :categories_array, only: [:index,        :new, :edit, :create, :update]
  before_action :correct_user,     only: [                     :edit,          :update, :destroy]

  # GET /items
  # GET /items.json
  def index
    @items = Item.paginate(page: params[:page], per_page: 10).search(params[:query], params[:category_id])
    #
  end

  # GET /items/1
  # GET /items/1.json
  def show
    @bid  = Bid.new
    @bids = Bid.where('item_id = ?', @item.id)
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params)

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

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
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
    params.require(:item).permit(:name, :description, :user_id, :starting_price, :category_id)
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: 'Please sign in.'
    end
  end

  def correct_user
    unless signed_in? && (current_user?(@item.user) || current_user.admin?)
      redirect_to items_url, alert: "You can't do that!?."
    end
  end
end
