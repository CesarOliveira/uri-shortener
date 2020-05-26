Rails.application.routes.draw do
  scope :api, defaults: { format: :json } do

    resources :links, only: [:create]
    get '/links/hits', to: 'links#hits'
  end

  get '/:identifier', to: 'links#redirect'
end
