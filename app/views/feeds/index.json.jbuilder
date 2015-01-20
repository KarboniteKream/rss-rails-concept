json.array!(@feeds) do |feed|
  json.extract! feed, :id, :id, :name, :icon
  json.url feed_url(feed, format: :json)
end
