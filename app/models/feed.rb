class Feed < ActiveRecord::Base
	validates :name, :presence => true
end
