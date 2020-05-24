class Link::Find
  def initialize(params, link_repository)
    @params = params
    @link_repository = link_repository
  end

  def run
    return @link_repository.find_by_identifier(@params['identifier']) if @params['identifier'].present?
    @link_repository.find_by(@params)
  end
end
