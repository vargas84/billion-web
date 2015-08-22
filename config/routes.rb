Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  devise_for :users

  root to: 'pages#show', id: 'landing'

  post '/subscribe', to: 'subscribe#create', as: 'subscribe'
  resources 'bam_applications', only: [:create]
  resources :projects, only: [:show]
end
