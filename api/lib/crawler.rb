require 'open-uri'

module Crawler
  class << self
    def get_title(url)
      doc = Nokogiri::HTML(open(url))
      doc.at('title').text
    rescue
      'title not found'
    end
  end
end
