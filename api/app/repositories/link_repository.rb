module LinkRepository
  extend self
  include CacheHelper

  def find(id)
    Link.find(id)
  end

  def update(link, params)
    link.update(params)
  end

  def create(params)
    Link.create!(params)
  end

  def find_by(*args)
    Link.find_by(*args)
  end

  def find_by_identifier(identifier)
    CacheHelper.fetch(identifier, 1.day) do
      Link.find_by(identifier: identifier)
    end
  end

  def links_hits
    Link.count_hits
  end
end
