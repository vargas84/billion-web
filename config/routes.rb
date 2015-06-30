Rails.application.routes.draw do
  post '/subscribe', to: 'subscribe#create', as: 'subscribe'
  resources 'bam_applications', only: :create

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
