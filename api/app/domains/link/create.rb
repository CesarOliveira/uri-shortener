class Link::Create
  def initialize(params, link_repository)
    @params = params
    @link_repository = link_repository
  end

  def save
    ActiveRecord::Base.transaction do
      @link = @link_repository.create(@params.merge!(identifier: generate_unique_identifier))
    end
    set_link_title
    @link
  rescue StandardError => e
    { errors: e.message }
  end

  private

    def generate_unique_identifier(size_hash = ENV['INITIAL_SIZE_OF_HASH'].to_i)
      unique_hash = SecureRandom.alphanumeric(size_hash)

      return unique_hash unless @link_repository.find_by(identifier: unique_hash)

      generate_unique_identifier(size_hash + 1)
    end

    def set_link_title
      LinkSetTitlePublisher.run(@link.id)
    end
end
