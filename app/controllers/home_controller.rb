class HomeController < ApplicationController
  helper_method :nullSubscriptions, :folders, :folderSubscriptions, :unread

  def unread
	Unread.where(user_id: session[:userID]).select("COUNT(article_id) AS unread").first.unread
  end

  def home
    if session[:userID] == nil
		redirect_to :controller => "landing"
	end
	
	@featured = Article.joins("JOIN likeds ON id = likeds.article_id").select("articles.id, articles.title, articles.url, articles.author, articles.date, articles.content").group("likeds.article_id").order("COUNT(likeds.article_id) DESC")
  end

  def signout
	session[:userID] = nil
	redirect_to :controller => "landing"
  end

  def unsubscribe
	Subscription.where(:user_id => session[:userID], :feed_id => params[:id]).delete_all
	#Unread.joins("LEFT JOIN articles ON articles.id = article_id").joins("JOIN feeds ON feeds.id = articles.feed_id").where("feeds.id = ?", params[:id]).delete_all
	redirect_to :action => "home"
  end

  def add
	require 'open-uri'

	url = params[:subscription][:url]

	if url.starts_with?("http://") == false
		url = "http://" + url
	end

	doc = Nokogiri::XML(open(url))

	name = doc.at_xpath("//channel/title").content
	icon = open("http://www.google.com/s2/favicons?domain=" + url).read

	feed = Feed.new(:name => name, :icon => icon)
	feed.save

	Subscription.new(:user_id => session[:userID], :feed_id => feed.id).save

	doc.xpath("//item").each do |article|
		temp = Article.new(:feed_id => feed.id, :title => article.at_xpath(".//title").content, :url => article.at_xpath(".//link").content, :author => nil, :date => DateTime.now, :content => article.at_xpath(".//description").content)
		temp.save
		Unread.new(:user_id => session[:userID], :article_id => temp.id).save
	end

	redirect_to :action => "feed", id: feed.id
  end

  def feed
    if session[:userID] == nil
		redirect_to :controller => "landing"
	end
	
	@feedID = params[:id].to_i

	if(@feedID.nil? || @feedID == 0 || @feedID == -1)
		redirect_to action: "home"
		return
	end

	if @feedID > 0
		@feedName = Feed.find(@feedID).name

		@articles = Article.joins("JOIN feeds ON feeds.id = articles.feed_id").joins("JOIN unreads ON articles.id = unreads.article_id").joins("JOIN users ON users.id = unreads.user_id").where("articles.feed_id = ? AND users.id = ?", @feedID, session[:userID]).order("articles.date DESC").select("articles.id, articles.title, articles.url, articles.author, articles.date, articles.content, 1 AS unread, 0 AS liked")
	else
		case @feedID
		when -2
			@feedName = "Unread articles"
				
			@articles = Article.joins("JOIN unreads ON articles.id = unreads.article_id").joins("JOIN users ON users.id = unreads.user_id").joins("LEFT JOIN likeds ON articles.id = likeds.article_id").where("users.id = ?", session[:userID]).order("articles.date DESC").select("articles.id, articles.title, articles.url, articles.author, articles.date, articles.content, unreads.user_id AS unread, likeds.user_id AS liked")

		when -3
			@feedName = "Liked articles"
				
			@articles = Article.joins("JOIN likeds ON articles.id = likeds.article_id").joins("JOIN users ON users.id = likeds.user_id").where("users.id = ?", session[:userID]).order("articles.date DESC").select("articles.id, articles.title, articles.url, articles.author, articles.date, articles.content, 0 AS unread, likeds.user_id AS liked")

		when -4
			@feedName = "All articles"

			@articles = Subscription.joins("JOIN feeds ON subscriptions.feed_id = feeds.id").joins("JOIN articles ON feeds.id = articles.feed_id").joins("LEFT JOIN likeds ON articles.id = likeds.article_id").joins("LEFT JOIN unreads ON articles.id = unreads.article_id").where("subscriptions.user_id = ?", session[:userID]).order("articles.date DESC").select("articles.id, articles.title, articles.url, articles.author, articles.date, articles.content, unreads.user_id AS unread, likeds.user_id AS liked")
		end
	end
  end

  def nullSubscriptions
	Subscription.where("user_id = ? AND (folder IS NULL OR folder = '')", session[:userID]).joins("JOIN feeds ON feed_id = feeds.id").order("feeds.name ASC").select("feeds.name, feed_id, feeds.icon, 0 AS unread")
  end

  def folders
	Subscription.where(user_id: session[:userID]).where("folder IS NOT NULL AND folder <> ''").select("folder").distinct.order("folder ASC")
  end

  def folderSubscriptions(folder)
	Subscription.where("user_id = ? AND folder = ?", session[:userID], folder).joins("JOIN feeds ON feed_id = feeds.id").order("feeds.name ASC").select("feeds.name, feed_id, feeds.icon, 0 AS unread")
  end
end
