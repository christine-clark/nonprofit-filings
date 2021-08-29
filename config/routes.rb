Rails.application.routes.draw do
  # If we need more routes later, we can always support all
  # resources :filers
  # resources :receivers

  # For now, we just need a GET endpoint for filers and receivers
  get '/filers', to: 'filers#index'
  get '/receivers', to: 'receivers#index'
end
