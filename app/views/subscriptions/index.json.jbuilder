json.array!(@subscriptions) do |subscription|
  json.extract! subscription, :id, :user_id, :feed_id, :folder
  json.url subscription_url(subscription, format: :json)
end
