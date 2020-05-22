class Link::Create
  def initialize(params, link_repository)
    @params = params
    @link_repository = link_repository
  end

  def save
    @link_repository.create(@params)
  end
end
