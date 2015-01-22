class User < ActiveRecord::Base
	attr_accessor :password

	before_save :encrypt_password

	validates :real_name, :presence => true
	validates :email, :presence => true, :uniqueness => true, :format => /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i
	validates :password, :confirmation => true

	def encrypt_password
		unless password.blank?
			self.salt = BCrypt::Engine.generate_salt
			self.encrypted_password = BCrypt::Engine.hash_secret(password, salt)
		end
	end
end
