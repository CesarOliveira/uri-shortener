Rails.application.routes.draw do
  scope :api, defaults: { format: :json } do

    resources :links, only: [:create]
  end

  get '/:identifier', to: 'links#redirect'
end
