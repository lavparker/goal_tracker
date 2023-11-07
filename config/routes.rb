Rails.application.routes.draw do
  namespace :api do
    get 'test/create'
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  namespace :api, defaults: { format: :json } do
    resources :users, only: :create
    resource :session, only: [:show, :create, :destroy]
    post 'test', to: 'test#create'
  end


  # Defines the root path route ("/")
  # root "articles#index"
end
