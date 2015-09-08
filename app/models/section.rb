class Section < ActiveRecord::Base
	belongs_to :page

	mount_uploader :img_url, ImageUploader

	acts_as_list scope: :page 

	validates :page_id, presence: true 
	validates :name, presence: true
	validates :position, presence: true
	validates :content, presence: true
	
end
