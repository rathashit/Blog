class PagesController < ApplicationController

  before_action :confirm_login
  before_action :find_admin
  
  layout 'admin' 

  def index
    @pages = @admin.pages.all.order('title asc')
  end

  def show
    @page = Page.find(params[:id])
  end

  def delete
    @page = Page.find(params[:id])
  end

  def destroy
    page = Page.find(params[:id])
    page.destroy
    flash[:notice] = "Page deleted sucessfully"
    redirect_to(:action => 'index')
  end

  def edit
    @categories = Category.all.order('Name ASC')
    @page = Page.find(params[:id])
  end

  def update
    @page = Page.find(params[:id])
    if @page.update_attributes(page_parameters)
      flash[:notice] = "Page updated sucessfully"
      redirect_to(:action => 'show', :id => @page.id)
    else
      flash[:notice] = "Page could not be updated"
      @categories = Category.all.order('Name ASC')
      render('edit')
    end 
  end

  def new
    @page = Page.new
    @categories = Category.all.order('Name ASC')
  end

  def create
    @page = Page.new(page_parameters)
    @page.hit_count = 0
    if @page.save
      PageEdit.create(:page => @page, :admin_user => @admin)
      flash[:notice] = "Page created sucessfully"
      redirect_to(:action => 'show', :id => @page.id)
    else
      @categories = Category.all.order('Name ASC')
      flash[:notice] = "Page could not be created"
      render('new')
    end
  end

  def view
    @page = Page.find(params[:id])
    redirect_to(:controller => 'sections', :action => 'index' ,:page_id => @page.id)
  end

  def remove_img
    page = Page.find(params[:id])
    page.remove_image_url!
    page.image_url = "no image" 
    page.save
    redirect_to(:action => 'show', :id => page.id)
  end
  private
  def page_parameters
    params.require(:page).permit(:title, :image_url, :content, :category_id, :visible)
  end

  def find_admin
    userId = session[:user_id]
    @admin = AdminUser.find(userId)
  end
end
