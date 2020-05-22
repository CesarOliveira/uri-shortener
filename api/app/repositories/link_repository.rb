module LinkRepository
  extend self

  def create(params)
    Link.create!(params)
  end
end
