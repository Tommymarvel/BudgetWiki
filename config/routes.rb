Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'splash_screen#index'

  resources :categories, only: %i[index show create update destroy new edit] do
    resources :entities, only: %i[index create show update destroy new edit]
  end
end
