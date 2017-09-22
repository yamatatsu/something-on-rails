Rails.application.routes.draw do
  root controller: :top, action: :index

  resources :people, only: %w(index)
end
