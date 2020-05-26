module LinkSetTitlePublisher
  extend self

  def run(link_id)
    Hutch.connect

    Hutch.publish('link.set.title', { link_id: link_id} )
  end
end
