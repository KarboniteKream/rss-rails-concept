json.array!(@users) do |user|
  json.extract! user, :id, :id, :real_name, :email, :password, :cookie
  json.url user_url(user, format: :json)
end
