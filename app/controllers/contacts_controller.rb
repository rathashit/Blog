class ContactsController < ApplicationController
  
  before_action :confirm_login
  before_action :find_admin

  layout 'admin'

  def index
  	@unreadContacts = Contact.all.where(:read => 0).order('created_at DESC')
  	@readContacts = Contact.all.where(:read => 1).order('created_at DESC')
  end

  def show
  	@message = Contact.find(params[:id])
  	@message.read = true
  	@message.save
  end

  def delete
  	@message = Contact.find(params[:id])
  end

  def destroy
  	@message = Contact.find(params[:id])
  	@message.destroy
  	flash[:notice] = "Message deleted sucessfully"
  	redirect_to(:action => 'index')
  	
  end

  private

  def find_admin
    userId = session[:user_id]
    @admin = AdminUser.find(userId)
  end
end
