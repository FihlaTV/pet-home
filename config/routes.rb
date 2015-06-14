Rails.application.routes.draw do
  get 'categories/index'

  get 'categories/show'

  get 'sessions/new'

 root                       'static_pages#home'
 get    'help'           => 'static_pages#help'
 get    'about'          => 'static_pages#about'
 get    'contact'        => 'static_pages#contact'
 get    'signup'         => 'users#new'
 get    'login'          => 'sessions#new'
 post   'login'          => 'sessions#create'
 delete 'logout'         => 'sessions#destroy'
 resources :users
 resources :categories, only: [:index, :show] do
 end
end
