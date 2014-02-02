class CategoriesController < ApplicationController
  before_action :isAdmin
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.all
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: 'Category was successfully created.' }
        format.json { render action: 'show', status: :created, location: @item }
      else
        format.html { render action: 'new' }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    if items?
      # display error
      logger.debug '--- has_items = true'
      respond_to do |format|
        format.html { redirect_to @category, notice: 'Delete Failed: Category has items.' }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    else
      @category.destroy
      respond_to do |format|
        format.html { redirect_to categories_url }
        format.json { head :no_content }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_category
    @category = Category.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def category_params
    params.require(:category).permit(:name, :description)
  end

  #
  def items?
    Item.where('category_id = ?', @category.id).count > 0
  end

  # Admin Heading
  def isAdmin
    if signed_in? && current_user.admin?
      @admin = true
    else
      flash[:alert] = "You're not allowed to do that..."
      redirect_to root_url
    end
  end
end
