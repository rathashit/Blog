class Contact < ActiveRecord::Base

	EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i

	validates :name, presence: true, :length => { :maximum => 75 }
	validates :email, presence: true, :length => { :maximum => 100 }, :format => EMAIL_REGEX
	validates :message, presence: true, :length => { :maximum => 500 }
end
