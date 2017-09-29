Rails.application.routes.draw do
  devise_for :users
  root controller: :top, action: :index

  namespace :ikeda_note do
    resources :events, only: %w[index new create]
    resources :people, only: %w[index]
    resources :teams, only: %w[index]
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end
end
