json.items do
  json.array! @links_hits do |link|
    json.extract! link,
      :id,
      :title,
      :identifier,
      :destination_url,
      :total_hits,
      :unique_hits
  end
end
