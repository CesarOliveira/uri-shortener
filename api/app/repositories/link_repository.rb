module LinkRepository
  extend self

  def create(params)
    Link.create!(params)
  end

  def find_by(*args)
    Link.find_by(*args)
  end
end
