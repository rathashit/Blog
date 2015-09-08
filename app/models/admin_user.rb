class AdminUser < ActiveRecord::Base
	has_many :page_edits
	has_many :pages, :through => :page_edits    

	has_secure_password

	EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i

	validates :first_name, presence: true, :length => { :maximum => 25 }
	validates :last_name, presence: true,:length => { :maximum => 50 }
	validates :email, presence: true, uniqueness: true, :length => { :maximum => 100 }, :format => EMAIL_REGEX, confirmation: true
	validates :username, presence: true, uniqueness: true, :length => { :within => 4..25 }
	validates :password, length: { minimum: 6 }
	# validates :password_confirmation, presence: true
end
