Rails.application.routes.draw do
  root controller: :top, action: :index

  resources :people, only: %w[index]

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
