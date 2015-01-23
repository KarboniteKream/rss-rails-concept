class Subscription < ActiveRecord::Base
	validates :user_id, :feed_id, presence: true, numericality: true
	validates :folder, length: { maximum: 64 }
end
