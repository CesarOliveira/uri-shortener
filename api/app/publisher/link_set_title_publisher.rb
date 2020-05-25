module LinkSetTitlePublisher
  extend self

  def run(link_id)
    Hutch.connect

    data = {
      link_id: link_id
    }

    Hutch.publish('link.set.title', subject: data)
  end
end
