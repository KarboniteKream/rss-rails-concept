class HomeController < ApplicationController
  helper_method :folderSubscriptions, :changeFeed

  def feed
	@feedID = params[:id].to_i

	if(@feedID == nil || @feedID == 0)
		@feedID = 1
	elsif(@feedID < 0)
		case @feedID
		when -1
			redirect_to action: "home"
		when -2
		when -3
		when -4
		end
		return
	end

	@feed = Feed.find(@feedID)

	@articles = Article.joins("JOIN feeds ON feeds.id = articles.feed_id").joins("JOIN unreads ON articles.id = unreads.article_id").joins("JOIN users ON users.id = unreads.user_id").where("articles.feed_id = ? AND users.id = ?", @feedID, 1).order("articles.date DESC").select("articles.id, articles.title, articles.url, articles.author, articles.date, articles.content")

	@nullSubscriptions = Subscription.where("user_id = ? AND (folder IS NULL OR folder = '')", 1).joins("JOIN feeds ON feed_id = feeds.id").order("feeds.name ASC").select("feeds.name, feed_id, feeds.icon")

	@folders = Subscription.where(user_id: 1).where("folder IS NOT NULL AND folder <> ''").select("folder").distinct.order("folder ASC")

	@unread = 75
  end

  def folderSubscriptions(folder)
	Subscription.where("user_id = ? AND folder = ?", 1, folder).joins("JOIN feeds ON feed_id = feeds.id").order("feeds.name ASC").select("feeds.name, feed_id, feeds.icon")
  end

  def changeFeed
  end
end
