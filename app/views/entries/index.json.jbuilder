json.array!(@entries) do |entry|
  json.extract! entry, :id, :text, :date, :user_id, :image_url, :instagram_media_id
  json.url entry_url(entry, format: :json)
end
