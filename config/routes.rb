Rails.application.routes.draw do
  resources :diaries, only: [:new, :create, :show]
  root 'diaries#new'
  get 'diaries/new'
  get 'diaries/create'
  get 'diaries/show'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  if Rails.env.production?
    namespace :admin do
      resources :migrations, only: [:index]
    end
  end
end

