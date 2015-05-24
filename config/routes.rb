Rails.application.routes.draw do
  post '/subscribe', to: 'subscribe#create', as: 'subscribe'
end
