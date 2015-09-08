class Page < ActiveRecord::Base
	has_many :page_edits
	has_many :admin_users, :through => :page_edits 
	belongs_to :category
	has_many :sections

	before_save :add_default_permalink
	mount_uploader :image_url, ImageUploader

	validates :title, presence: true
	# validates :image_url, presence: true
	validates :category_id, presence: true
	validates :content, presence: true

	private

	def add_default_permalink
		if permalink.blank?
			self.permalink = "#{id}-#{title.parameterize}"
		end
	end

end
