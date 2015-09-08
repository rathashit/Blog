class CategoriesController < ApplicationController

  before_action :confirm_login
  
  layout 'admin'
  
  def index
    @categories = Category.all.order('name ASC')
  end

  def show
    @category = Category.find(params[:id])
  end

  def delete
    @category = Category.find(params[:id])
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    flash[:notice] = "Category deleted sucessfully"
    redirect_to(:action => 'index')
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(cat_params)
      flash[:notice] = "Category updated sucessfully"
      redirect_to(:action => 'show', :id => @category.id)
    else
      flash[:notice] = "Something went wrong"
      render('edit')
    end
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(cat_params)
    if @category.save
      flash[:notice] = "Category created sucessfully"
      redirect_to(:action => 'show', :id => @category.id)
    else
      flash[:notice] = "Something went wrong"
      render('new')
    end
  end

  private
  def cat_params
    params.require(:category).permit(:name, :img_url, :desc)
  end
end
