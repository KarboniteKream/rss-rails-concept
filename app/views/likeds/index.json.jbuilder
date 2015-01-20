json.array!(@likeds) do |liked|
  json.extract! liked, :id, :user_id, :article_id
  json.url liked_url(liked, format: :json)
end
