class Liked < ActiveRecord::Base
	validates :user_id, :article_id, :presence => true, :uniqueness => true
end
