json.link do
  json.extract! @link,
    :id,
    :title,
    :destination_url
  json.shorted_link "#{ENV['DEFAULT_URL']}/#{@link.identifier}"
end
