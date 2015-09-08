class PublicController < ApplicationController
  
  layout 'public'
  
  before_action :find_pages

  def index
  	@pages = Page.all.where(:visible => true).order('created_at DESC')
  end

  def about
    render :layout => false
  end

  def view
  	@page = Page.where(:permalink => params[:permalink],:visible => true ).first
  	if @page.nil?
  		redirect_to(:action => 'index')
  	else
  		@page.hit_count += 1
      @page.save
  	end
  end

  def contact
    @contact = Contact.new
  end

  def save_message
    @contact = Contact.new(contact_params)
    if @contact.save
      flash[:notice] = "Message Sent Sucessfully"
      redirect_to(:action => 'contact')
    else
      flash[:notice] = "Something went wrong"
      render('contact')
    end
  end

  private
  def find_pages
    @latestPages = Page.all.where(:visible => true).order('created_at DESC').limit(4)
    @popularPages = Page.all.where(:visible => true).order('hit_count DESC').limit(4)
  end

  def contact_params
    params[:contact].permit(:name, :email, :message)
  end
end
