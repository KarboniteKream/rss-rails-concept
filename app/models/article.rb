class Article < ActiveRecord::Base
	validates :feed_id, :title, :content, :presence => true
end
