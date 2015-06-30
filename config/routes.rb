Rails.application.routes.draw do
  post '/subscribe', to: 'subscribe#create', as: 'subscribe'
  resources 'bam_applications', only: :create

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
