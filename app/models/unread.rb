class Unread < ActiveRecord::Base
	validates :user_id, :article_id, presence: true, numericality: true
end
