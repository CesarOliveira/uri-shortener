class Link::Find
  def initialize(params, link_repository)
    @params = params.to_h
    @link_repository = link_repository
  end

  def run
    return @link_repository.find_by_identifier(@params['identifier']) if find_only_by_identifier?
    @link_repository.find_by(@params)
  end

  private
    def find_only_by_identifier?
      @params.size == 1 && @params['identifier'].present?
    end
end
