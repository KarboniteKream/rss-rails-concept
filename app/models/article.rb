class Article < ActiveRecord::Base
	validates :feed_id, :title, :content, :presence => true
	validates :feed_id, numericality: true
end
