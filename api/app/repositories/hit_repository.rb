module HitRepository
  extend self

  def create(params)
    Hit.create!(params)
  end
end
