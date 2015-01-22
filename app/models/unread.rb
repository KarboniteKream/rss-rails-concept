class Unread < ActiveRecord::Base
	validates :user_id, :article_id, :presence => true
end
