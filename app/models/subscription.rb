class Subscription < ActiveRecord::Base
	validates :user_id, :feed_id, :presence => true, :uniqueness => true
end
