class HomeController < ApplicationController
  def feed
	@feed = Feed.find(6)

	@articles = Article.joins("JOIN feeds ON feeds.id = articles.feed_id").joins("JOIN unreads ON articles.id = unreads.article_id").joins("JOIN users ON users.id = unreads.user_id").where("articles.feed_id = 6 AND users.id = 1").select("articles.id, articles.title, articles.url, articles.author, articles.date, articles.content")

	@subscriptions = Subscription.where("user_id = 1 AND (folder IS NULL OR folder = '')").joins("JOIN feeds ON feed_id = feeds.id").order("feeds.name ASC").select("feeds.name, feed_id, feeds.icon")

	@folders = Subscription.where("user_id = 1").where("folder IS NOT NULL AND folder <> ''").select("folder").distinct.order("folder ASC")

	@unread = 75
  end
end
