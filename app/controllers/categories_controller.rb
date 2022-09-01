class CategoriesController < ApplicationController

  before_action :set_category, only: [:edit, :update, :show, :destroy]
  before_action :check_admin, only: [:new, :create, :edit, :update, :destroy]


  def index
    @category = Category.all
  end

  def new
    puts "nrew categroy"
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      flash[:success] = "category saved successfully"
      redirect_to categories_path
    else
      render :new
    end

  end

  def edit

  end

  def update
    if @category.update(category_params)
      flash[:success] = "category updated success"
      redirect_to categories_path
    else
      render :edit
    end

  end

  def show

  end

  def destroy
    @category.destroy
    flash[:danger] = "Category Deleted"
    redirect_to categories_path
  end

  private

  def set_category
    @category = Category.find_by(id: params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end

  def check_admin
    if !logged_in || (logged_in and !current_user.admin?)
      flash[:danger] = "you must have admin rights before perform this action"
      redirect_to root_path
    end
  end

end