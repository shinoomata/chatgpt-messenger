Rails.application.routes.draw do
  resources :messages, only: [:new, :create, :show]
  root 'messages#new'
  get 'messages/new'
  get 'messages/create'
  get 'messages/show'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
