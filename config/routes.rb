Rails.application.routes.draw do

  root                       'static_pages#home'
  get    'help'           => 'static_pages#help'
  get    'about'          => 'static_pages#about'
  get    'contact'        => 'static_pages#contact'
  get    'signup'         => 'users#new'
  get    'login'          => 'sessions#new'
  post   'login'          => 'sessions#create'
  delete 'logout'         => 'sessions#destroy'
  get    'auth/:provider/callback', to: 'sessions#facebook_oauth'

  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :locations

  resources :categories do
    resources :posts, except: [:index], controller: 'categories/posts'
  end

  resources :conversations, only: [:index, :create] do
    resources :messages, only: [:index, :create, :destroy]
  end

  resources :posts, only: [:index] do
    resources :postattachments
    collection do
      get 'search'
    end
  end

end
