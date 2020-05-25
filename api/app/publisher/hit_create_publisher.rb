module HitCreatePublisher
  extend self

  def run(link_id, identifier)
    Hutch.connect

    data = {
      link_id: link_id,
      identifier: identifier
    }

    Hutch.publish('hit.create', subject: data)
  end
end
