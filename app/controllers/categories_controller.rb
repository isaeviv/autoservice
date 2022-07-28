class CategoriesController < ApplicationController
  
  # load_and_authorize_resource
  before_action :set_category, only: %i[ show edit update destroy ]
  
  def index
    @categories = Category.all
  end
  
  def show
  end

  def new
    @category = Category.new
  end

  def update
    if @category.update permitted_category_params
      redirect_to category_url(@category), notice: "Category was successfully updated."
    else
      render :edit
    end
  end

  def create
    @category = Category.new(permitted_category_params)

    if @category.save
      redirect_to categories_path, notice: "Category was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def destroy
    @category.destroy
    redirect_to categories_url, notice: "Category was successfully destroyed."
  end
  
  private
    def set_category
      @category =  Category.find(params[:id])
    end

    def permitted_category_params
      params[:category].permit(:name, :order_id, :specialist_id, :price)
    end
  
end
