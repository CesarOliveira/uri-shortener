module LinkRepository
  extend self
  include CacheHelper

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
end
