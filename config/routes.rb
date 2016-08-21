Rails.application.routes.draw do
  resources :games, only: :show
  resources :cells, only: :update
end
