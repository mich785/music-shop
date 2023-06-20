Rails.application.routes.draw do
  resources :instruments , only: [:index, :show, :update, :create, :destroy]
  resources :shops, only: [:index, :show, :update, :create, :destroy]

end
