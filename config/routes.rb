Rails.application.routes.draw do
  devise_for :users
  root controller: :top, action: :index

  namespace :ikeda_note do
    resources :events, only: %w[index new create edit update destroy]
    resources :people, only: %w[index new create edit update destroy]
    resources :teams, only: %w[index new create edit update destroy]
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end
end
