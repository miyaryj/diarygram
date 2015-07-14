json.array!(@instagram_users) do |instagram_user|
  json.extract! instagram_user, :id, :name, :user_id, :instagram_user_id, :profile_image_url
  json.url instagram_user_url(instagram_user, format: :json)
end
