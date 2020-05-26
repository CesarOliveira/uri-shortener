require 'hutch'

class LinkSetTitleConsumer
  include Hutch::Consumer
  consume 'link.set.title'

  def process(message)
    link = LinkRepository.find(message[:link_id])

    title = Crawler.get_title(link.destination_url)

    LinkRepository.update(link, title: title)
  end
end
