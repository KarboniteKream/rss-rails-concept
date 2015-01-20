json.array!(@articles) do |article|
  json.extract! article, :id, :id, :feed_id, :title, :url, :author, :date, :content
  json.url article_url(article, format: :json)
end
