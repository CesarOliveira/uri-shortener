class Hit::Create
  def initialize(params, hit_repository)
    @params = params
    @hit_repository = hit_repository
  end

  def save
    ActiveRecord::Base.transaction do
      @hit_repository.create(@params)
    end
  rescue StandardError => e
    { errors: e.message }
  end
end
