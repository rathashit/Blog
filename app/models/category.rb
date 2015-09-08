class Category < ActiveRecord::Base
	has_many :pages

	validates :name, presence: true
	validates :img_url, presence: true
	validates :desc, presence: true
end
