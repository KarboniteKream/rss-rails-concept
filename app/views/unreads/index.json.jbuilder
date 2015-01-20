json.array!(@unreads) do |unread|
  json.extract! unread, :id, :user_id, :article_id
  json.url unread_url(unread, format: :json)
end
