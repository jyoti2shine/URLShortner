Rails.application.routes.draw do
  resources :short_urls
  resource :users ,only: [:create] do
    post :regenerate_token
    get :authenticate
  end
  get '/:shorty', to: 'short_urls#show', as: :shorty
  get '/:shorty/geo_detail', to: "short_urls#extract"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end